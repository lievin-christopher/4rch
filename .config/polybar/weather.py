import requests
icons = {
        "clear sky":"%{F#ebbe65}",
         "few clouds":"",
         "overcast clouds":"",
         "scattered clouds":"%{F#709080}",
         "broken clouds":"",
         "shower rain":"",
         "rain":"%{F#02c9ff}",
         "thunderstorm":"",
         "snow":"%{F#02c9ff}",
         "mist":""
}


def get_weather_forecast(longitude=3.06, latitude=50.63):
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
    weather = get_weather_forecast()
    ico = icons.get(weather.get("weather")[0].get("description"))
    if not ico:
        ico = weather.get("weather")[0].get("description")
    temp = weather.get("main").get("temp")
    if not temp:
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
    print(ico+" "+status+str(temp)+"°C")
except:
    print("%{F#bf616a}")
