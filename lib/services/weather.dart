import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

var openWeatherURL = 'https://api.openweathermap.org/data/2.5/weather';
var apiKey = 'b7f98d6dc32f110ec8d43c45cd0f359a';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        Uri.parse('$openWeatherURL?q=$cityName&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location loc = Location();
    await loc.getCurrLocation();

    var url = Uri.parse(
        '$openWeatherURL?lat=${loc.latitude}&lon=${loc.longitude}&appid=$apiKey&units=metric');
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
