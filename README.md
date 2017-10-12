# XeroWeather

A weather app you can check the current weather for your location.

## Notes
- The app displays the current weather data and forecast weather data for your location.
- The app uses Location Service to get your location.
- [OpenWeatherMap](https://openweathermap.org) API is used to get weather data.
- XeroWeather main iOS app has a dependency called XeroWeatherCore.
- XeroWeatherCore has a dependency Alamofire for networking.
- WeatherAPI class is designed based on [objc.io's Swift Talk Episode 1](https://talk.objc.io/episodes/S01E01-networking).
- Some features, like Update location feature, Add location feature, have not been imeplemented yet. Sorry!
- No Storyboard.
- Swift 4's Codable protocol is heavily used in XeroWeatherCore.
- Carthage is used to add Alamofire. Please run carthage before running the app. 
