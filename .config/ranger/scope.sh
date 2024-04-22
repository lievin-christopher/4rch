#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

# If the option `use_preview_script` is set to `true`,
# then this script will be called and its output will be displayed in ranger.
# ANSI color codes are supported.
# STDIN is disabled, so interactive scripts won't work properly

# This script is considered a configuration file and must be updated manually.
# It will be left untouched if you upgrade ranger.

# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | Display stdout as preview
# 1    | no preview | Display no preview at all
# 2    | plain text | Display the plain content of the file
# 3    | fix width  | Don't reload when width changes
# 4    | fix height | Don't reload when height changes
# 5    | fix both   | Don't ever reload
# 6    | image      | Display the image `$IMAGE_CACHE_PATH` points to as an image preview
# 7    | image      | Display the file directly as an image

# Script arguments
FILE_PATH="${1}"         # Full path of the highlighted file
PV_WIDTH="${2}"          # Width of the preview pane (number of fitting characters)
PV_HEIGHT="${3}"         # Height of the preview pane (number of fitting characters)
IMAGE_CACHE_PATH="${4}"  # Full path that should be used to cache image preview
PV_IMAGE_ENABLED="${5}"  # 'True' if image previews are enabled, 'False' otherwise.

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="${FILE_EXTENSION,,}"

# Settings
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
HIGHLIGHT_TABWIDTH=8
HIGHLIGHT_STYLE='pablo'
PYGMENTIZE_STYLE='autumn'


handle_extension() {
    case "${FILE_EXTENSION_LOWER}" in
        # Archive
        a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip|sqd|cbz|cbr|mdf|tar.*)
            echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && echo '----- File Content -----'
            atool --list -- "${FILE_PATH}" && exit 5
            bsdtar --list --file "${FILE_PATH}" && exit 5
            exit 1;;
        7z|apk|img.xz|iso|rar)
            # Avoid password prompt by providing empty password
            7z l -p -- "${FILE_PATH}" && exit 5
            exit 1;;
        rpa)
            unrpa -l -- "${FILE_PATH}" && exit 5
            exit 1;;

        # PDF
        pdf)
            # Preview as text conversion
            pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        # WORD
        doc|docx)
            # Preview as text conversion
            unoconv -f txt "${FILE_PATH}" && exit 5
            bsdtar -O -f "${FILE_PATH}" -x word/document.xml | sed -e 's/<[^>]\{1,\}>//g; s/[^[:print:]]\{1,\}//g;s/\h/\n/g;s/[0-9]*-[0-9]*-[0-9]*//;/^$/d' && exit 5
            exit 1;;

        # EXEL
        xls|xlsx)
            # Preview as text conversion
            unoconv -f txt "${FILE_PATH}" && exit 5
            mkdir /tmp/preview_exel; bsdtar -f "${FILE_PATH}" -x --cd /tmp/preview_exel; echo -n "" > /tmp/preview_exel/worksheets.txt ; for sheet in $(find /tmp/preview_exel/xl/worksheets -name '*.xml' |  sort -V);do echo "##### ${sheet} #####" >> /tmp/preview_exel/worksheets.txt; grep -oE '<c r="[a-zA-Z0-9]+" (s="[0-9]+"( )*)*(t="[0-9a-zA-Z]")*><v>[a-zA-Z.,0-9]+</v></c>' ${sheet} | sed -E 's@<(/)*c( )*(>)*@@g;s@[st]="[0-9s]*"@@g;s@r="@@g;s@" *>@;@g;s@<(/)*v>@@g' >> /tmp/preview_exel/worksheets.txt;done ; sed -E 's@<si>@\n<si>@g;s@<(/)*t( xml:[a-zA-Z]*="[a-zA-Z]*")*>@@g;s@<(/)*si>@@g;s@<(/)*sst>@@g' /tmp/preview_exel/xl/sharedStrings.xml | tail -n +2 > /tmp/preview_exel/sharedStrings.txt ; awk -F ';' 'NR==FNR {a[NR-1]=$0;next} ($2 in a){print $1";"a[$2]} !($2 in a) {print $1";"$2}' /tmp/preview_exel/sharedStrings.txt /tmp/preview_exel/worksheets.txt; rm -rf /tmp/preview_exel ; exit 5
            exit 1;;

        # BitTorrent
        torrent)
            transmission-show -- "${FILE_PATH}" && exit 5
            exit 1;;

        # OpenDocument
        odt|ods|odp|sxw)
            # Preview as text conversion
            odt2txt "${FILE_PATH}" && exit 5
            exit 1;;

        # HTML
        htm|html|xhtml)
            # Preview as text conversion
            w3m -dump "${FILE_PATH}" && exit 5
            lynx -dump -- "${FILE_PATH}" && exit 5
            elinks -dump "${FILE_PATH}" && exit 5
            ;; # Continue with next handler on failure
    esac
}

handle_image() {
    local mimetype="${1}"
    case "${mimetype}" in
        # SVG
        image/svg+xml)
            convert "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && exit 6
            exit 1;;

        # AVIF
        image/heif)
            convert "${FILE_PATH}" "${IMAGE_CACHE_PATH}" && exit 6
            exit 1;;

        # Image
        image/*)
            # `w3mimgdisplay` will be called for all images (unless overriden as above),
            # but might fail for unsupported types.
            exit 7;;

        # Video
        video/*)
             # Thumbnail
             ffmpegthumbnailer -i "${FILE_PATH}" -o "${IMAGE_CACHE_PATH}" -s 0 && exit 6
             exit 1;;
    esac
}

handle_mime() {
    local mimetype="${1}"
    case "${mimetype}" in
        # Text
        text/* | */xml | application/json)
            # Syntax highlight
            if [[ "$( stat --printf='%s' -- "${FILE_PATH}" )" -gt "${HIGHLIGHT_SIZE_MAX}" ]]; then
                exit 2
            fi
            if [[ "$( tput colors )" -ge 256 ]]; then
                local pygmentize_format='terminal256'
                local highlight_format='xterm256'
            else
                local pygmentize_format='terminal'
                local highlight_format='ansi'
            fi
            highlight --replace-tabs="${HIGHLIGHT_TABWIDTH}" --out-format="${highlight_format}" \
                --style="${HIGHLIGHT_STYLE}" -- "${FILE_PATH}" && exit 5
            pygmentize -f "${pygmentize_format}" -O "style=${PYGMENTIZE_STYLE}" -- "${FILE_PATH}" && exit 5
            exit 2;;

        # Image
        image/*)
            # Preview as text conversion
            # img2txt --gamma=0.6 --width="${PV_WIDTH}" -- "${FILE_PATH}" && exit 4
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;

        # Video and audio
        video/* | audio/*)
            mediainfo "${FILE_PATH}" && exit 5
            exiftool "${FILE_PATH}" && exit 5
            exit 1;;
    esac
}

handle_fallback() {
    echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && file --dereference --brief -i -- "${FILE_PATH}" && exit 5
    exit 1
}


handle_extension
MIMETYPE="$( file --dereference --brief --mime-type -- "${FILE_PATH}" )"
if [[ "${PV_IMAGE_ENABLED}" == 'True' ]]; then
    handle_image "${MIMETYPE}"
fi
handle_mime "${MIMETYPE}"
handle_fallback

exit 1

