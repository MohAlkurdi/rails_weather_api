# README

This README would normally document whatever steps are necessary to get the
application up and running.

- Ruby version
  3.2.2

# Weather API Documentation

## Overview

The WeatherController class provides functionality to retrieve weather data from the WeatherAPI service based on city names.

## Dependencies

- This controller requires the `net/http` and `json` libraries.
- It relies on an API key (`WEATHER_API_KEY`) to access the WeatherAPI service.

## Methods

### `get_weather_data_by_city_name`

- **route**: `GET /weather/:city`
- **Description:** Retrieves current weather data for a single city.
  | Parameter | Type | Description |
  | :-------- | :------- | :---------------------- |
  | `city` | `string` | **Required**. City Name |

- **Returns:** JSON response containing weather data for the specified city.
- **Caching:** Uses Rails cache to store the weather data with an expiration time of 1 hour.

### `get_weather_data_for_multiple_cities`

- **route**: `POST /weather/multiple`
- **Description:** Retrieves current weather data for multiple cities.
- **Parameters:**
  - `cities`: An array of city names for which weather data is requested.
- **Returns:** JSON response containing weather data for each city in the input array.

### `get_weather_statistics`

- **route**: `GET /weather/statistics/:city`
- **Description:** Retrieves weather statistics (max temperature, min temperature, average temperature, and condition) for a single city.
  | Parameter | Type | Description |
  | :-------- | :------- | :---------------------- |
  | `city` | `string` | **Required**. City Name |

- **Returns:** JSON response containing weather statistics for the specified city.
- **Data Type:** Utilizes the `fetch_weather_data` method to retrieve forecast data for the specified city.

## Private Methods

### `fetch_weather_data(city, data_type)`

- **Description:** Fetches weather data from the WeatherAPI service based on the specified data type (current or forecast).
- **Parameters:**
  - `city`: The name of the city for which weather data is requested.
  - `data_type`: The type of weather data to retrieve (current or forecast).
- **Returns:** JSON response containing weather data for the specified city and data type.
- **API Endpoints:** Utilizes different endpoints based on the data type (current or forecast).

## Usage

- Ensure the `WEATHER_API_KEY` constant is set to a valid [WeatherAPI](https://www.weatherapi.com) key.
- Use the provided methods to retrieve weather data for single or multiple cities, and obtain weather statistics for a specific city.
