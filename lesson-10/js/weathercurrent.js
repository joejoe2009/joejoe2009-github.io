let weatherRequest = new XMLHttpRequest();
weatherRequest.open('GET', 'http://api.openweathermap.org/data/2.5/weather?id=5061036&appid=02acf3eba1e20146f0800379e8cb831c&units=imperial',true);

weatherRequest.send();

weatherRequest.onload =  function () {
    let weatherData = JSON.parse(weatherRequest.responseText);
    console.log(weatherData);

    document.getElementById('currently').innerHTML = weatherData.weather[0].main;
    document.getElementById('current-temp').innerHTML = weatherData.main.temp;
    document.getElementById('current-humi').innerHTML = weatherData.main.humidity;
    document.getElementById('current-wind').innerHTML = weatherData.wind.speed;


}

