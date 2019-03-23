var prestonWeather = new XMLHttpRequest();
prestonWeather.open('GET', 'http://api.openweathermap.org/data/2.5/forecast?id=5061036&appid=02acf3eba1e20146f0800379e8cb831c&units=imperial', true);

prestonWeather.send();

prestonWeather.onload = function() {
    var weatherInfo = JSON.parse(prestonWeather.responseText);
    console.log(weatherInfo);

    document.getElementById('desc1').innerHTML = weatherInfo.list[5].weather["0"].description;
    document.getElementById('hg1').innerHTML = weatherInfo.list[5].main.temp_max;
    document.getElementById('lw1').innerHTML = weatherInfo.list[5].main.temp_min;
    document.getElementById('wd1').innerHTML = weatherInfo.list[5].wind.speed;

    document.getElementById('desc2').innerHTML = weatherInfo.list[13].weather["0"].description;
    document.getElementById('hg2').innerHTML = weatherInfo.list[13].main.temp_max;
    document.getElementById('lw2').innerHTML = weatherInfo.list[13].main.temp_min;
    document.getElementById('wd2').innerHTML = weatherInfo.list[13].wind.speed;
    
    document.getElementById('desc3').innerHTML = weatherInfo.list[21].weather["0"].description;
    document.getElementById('hg3').innerHTML = weatherInfo.list[21].main.temp_max;
    document.getElementById('lw3').innerHTML = weatherInfo.list[21].main.temp_min;
    document.getElementById('wd3').innerHTML = weatherInfo.list[21].wind.speed;
    
    document.getElementById('desc4').innerHTML = weatherInfo.list[29].weather["0"].description;
    document.getElementById('hg4').innerHTML = weatherInfo.list[29].main.temp_max;
    document.getElementById('lw4').innerHTML = weatherInfo.list[29].main.temp_min;
    document.getElementById('wd4').innerHTML = weatherInfo.list[29].wind.speed;
   
    document.getElementById('desc5').innerHTML = weatherInfo.list[37].weather["0"].description;
    document.getElementById('hg5').innerHTML = weatherInfo.list[37].main.temp_max;
    document.getElementById('lw5').innerHTML = weatherInfo.list[37].main.temp_min;
    document.getElementById('wd5').innerHTML = weatherInfo.list[37].wind.speed;
}