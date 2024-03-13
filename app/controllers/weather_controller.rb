class WeatherController < ApplicationController
  require 'net/http'
  require 'json'

    # IMPORTANT: Replace this with your own API key
  WEATHER_API_KEY = <YOUR_WEATHER_API_KEY>

  def get_weather_data_by_city_name
    city = params[:city]

    weather_data = Rails.cache.fetch("weather_#{city}", expires_in: 1.hour) do
      fetch_weather_data(city, :current)
    end

    render json: weather_data
  end

  def get_weather_data_for_multiple_cities
    cities = params[:cities] || []

    weather_data = cities.map { |city| fetch_weather_data(city, :current) }

    render json: weather_data
  end

  def get_weather_statistics
    city = params[:city]

    response = fetch_weather_data(city, :forecast)

    if response['forecast'].present? && response['forecast']['forecastday'].present?
      weather_statistics = {
        max_temp: response['forecast']['forecastday'][0]['day']['maxtemp_c'],
        min_temp: response['forecast']['forecastday'][0]['day']['mintemp_c'],
        avg_temp: response['forecast']['forecastday'][0]['day']['avgtemp_c'],
        condition: response['forecast']['forecastday'][0]['day']['condition']['text']
      }

      render json: weather_statistics
    else
      render json: { error: 'Weather data not available' }, status: :unprocessable_entity
    end
  end

  private

  def fetch_weather_data(city, data_type)
    case data_type
    when :current
      uri = "http://api.weatherapi.com/v1/current.json?key=#{WEATHER_API_KEY}&q=#{city}&aqi=no"
    when :forecast
      uri = "http://api.weatherapi.com/v1/forecast.json?key=#{WEATHER_API_KEY}&q=#{city}&aqi=no&alerts=no"
    else
      raise ArgumentError, "Invalid data_type: #{data_type}"
    end

    url = URI(uri)
    response = Net::HTTP.get(url)
    JSON.parse(response)
  end
end
