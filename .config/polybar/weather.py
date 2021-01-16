import requests

longitude=3.06
latitude=50.63

icons = {
        "clear sky":"%{F#ebbe65}",
         "few clouds":"",
         "scattered clouds":"%{F#709080}",
         "broken clouds":"",
         "overcast clouds":"",
         "light rain":"",
         "moderate rain":"",
         "heavy intensity rain":"%{F#02c9ff}",
         "very heavy rain":"%{F#02c9ff}",
         "extreme rain":"%{F#02c9ff}",
         "freezing rain":"",
         "light intensity shower rain":"",
         "shower rain":"",
         "heavy intensity shower rain":"",
         "ragged shower rain":"",
         "thunderstorm with light rain":"",
         "thunderstorm with rain":"",
         "thunderstorm with heavy rain":"",
         "light thunderstorm":"",
         "thunderstorm":"",
         "heavy thunderstorm":"",
         "ragged thunderstorm":"",
         "thunderstorm with light drizzle":"",
         "thunderstorm with drizzle":"",
         "thunderstorm with heavy drizzle":"",
         "light snow":"%{F#02c9ff}",
         "snow":"%{F#02c9ff}",
         "heavy snow":"%{F#02c9ff}",
         "sleet":"%{F#02c9ff}",
         "shower sleet":"%{F#02c9ff}",
         "light rain and snow":"%{F#02c9ff}ﭽ",
         "rain and snow":"%{F#02c9ff}ﭽ",
         "light shower snow":"%{F#02c9ff}",
         "shower snow":"%{F#02c9ff}",
         "heavy shower snow":"%{F#02c9ff}",
         "mist":"",
         "smoke":"",
         "haze":"%",
         "fog":"",
         "sand":"%",
         "dust":"%",
         "volcanic ash":"%",
         "tornado":"%",
         "mist":""
}


def get_weather_forecast(longitude, latitude):
    # I'm living in a country that uses a unit system that makes sense.
    params = {"units": "metric",
              "appid": "2b5e29560749e7244342efc00227bae0",
              "lat": latitude, "lon": longitude}
    resp = requests.get("https://api.openweathermap.org/data/2.5/weather",
                        params=params)
    if not resp.ok:
        raise IOError(resp.text)
    return resp.json()
    
try:
    import os
    env = os.getenv('I3_TERM')
    prefix = '%{A:i3-sensible-terminal --title "__weather__" -g 74x46 -e bash -c "curl v2.wttr.in/'+str(latitude)+','+str(longitude)+' ;read":}'
    if env == "alacritty":
        prefix = '%{A:i3-sensible-terminal --title "__weather__" -o window.dimensions.columns=74 window.dimensions.lines=48 -e bash -c "curl v2.wttr.in/'+str(latitude)+','+str(longitude)+' ;read":}'
    suffix = '%{A}'
    weather = get_weather_forecast(longitude,latitude)
    ico = icons.get(weather.get("weather")[0].get("description"))
    if not ico:
        ico = weather.get("weather")[0].get("description")
    temp = weather.get("main").get("temp")
    if temp == None:
        temp = NaN
    status = ""
    if temp < 5.0:
        status = "%{F#76e2ff}"
    elif temp < 15.0:
        status = "%{F#02c9ff}"
    elif temp < 20.0:
        status = "%{F#60b48a}"
    else:
        status = "%{F#bf616a}"
    print(prefix+ico+" "+status+str(temp)+"°C"+suffix)
except:
    print("%{F#bf616a}")
