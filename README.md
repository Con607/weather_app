# Weather App

Basic weather app that connects to Open Weather and retrieves the current weather from your current location or from a city by name.

## Ruby version
`3.2.2`

## How to start in development
Just run 
```
bundle install
```
Then run the migrations 
```
rails db:migrate
```
Then start the server
```
bin/dev
```

## How to use
- To start just click on `Find my location` link
  - It should populate the search field with the name of your city
  - Press the search button so it retrieves the weather from that location
- You can also type the name of a city on the search box
  - The search box does not have autocomplete or any search for cities
  - Type the name of the city and if found it will display the weather on that location


Note: The data gets saved in the database and everytime you try to fetch the same record it wont retrieve it from Open Weather anymore, unless the record was last fetched an hour ago.


