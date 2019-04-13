let weatherRequest1 = new XMLHttpRequest();
weatherRequest1.open('GET', '//api.openweathermap.org/data/2.5/weather?id=5061036&appid=02acf3eba1e20146f0800379e8cb831c&units=imperial',true);

weatherRequest1.send();

weatherRequest1.onload =  function () {
    let weatherData = JSON.parse(weatherRequest1.responseText);
    console.log(weatherData);

    document.getElementById('currently1').innerHTML = weatherData.weather[0].main;
    document.getElementById('current-temp1').innerHTML = weatherData.main.temp;
    document.getElementById('current-humi1').innerHTML = weatherData.main.humidity;
    document.getElementById('current-wind1').innerHTML = weatherData.wind.speed;


}