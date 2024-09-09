import requests
import matplotlib.pyplot as plt

# Replace with your OpenWeatherMap API key
API_KEY = '[API KEY]'

# Function to fetch weather data from the OpenWeatherMap API
def get_weather_data(city):
    url = f'http://api.openweathermap.org/data/2.5/weather?q={city}&appid={API_KEY}&units=metric'
    response = requests.get(url)
    return response.json()

# Function to fetch forecast data
def get_forecast_data(city):
    url = f'http://api.openweathermap.org/data/2.5/forecast?q={city}&appid={API_KEY}&units=metric'
    response = requests.get(url)
    return response.json()

# Function to display the current weather
def display_current_weather(weather_data):
    print(f"Current weather in {weather_data['name']}:")
    print(f"Temperature: {weather_data['main']['temp']}°C")
    print(f"Weather: {weather_data['weather'][0]['description']}")
    print(f"Humidity: {weather_data['main']['humidity']}%")
    print(f"Wind Speed: {weather_data['wind']['speed']} m/s")
    print("-" * 40)

# Function to visualize forecast data
def display_forecast_chart(forecast_data, city):
    temps = [item['main']['temp'] for item in forecast_data['list'][:8]]  # 8 time points
    times = [item['dt_txt'] for item in forecast_data['list'][:8]]

    # Create the plot
    fig, ax = plt.subplots()
    ax.plot(times, temps, marker='o')
    ax.set_title(f"Temperature Forecast for {city}")
    ax.set_xlabel('Time')
    ax.set_ylabel('Temperature (°C)')
    plt.xticks(rotation=45, ha='right')
    plt.tight_layout()

    # Display the plot
    plt.show()

# Main function to run the app
def main():
    city = input("Enter the name of the city: ")
    
    # Fetch current weather data
    weather_data = get_weather_data(city)
    if weather_data.get("cod") != 200:
        print(f"Error fetching weather data: {weather_data.get('message', 'Unknown error')}")
        return
    
    # Display current weather data
    display_current_weather(weather_data)
    
    # Fetch and display forecast data
    forecast_data = get_forecast_data(city)
    if forecast_data.get("cod") == "200":
        display_forecast_chart(forecast_data, city)
    else:
        print(f"Error fetching forecast data: {forecast_data.get('message', 'Unknown error')}")

if __name__ == '__main__':
    main()
