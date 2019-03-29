var forecastList = new XMLHttpRequest();
forecastList.open('GET', 'http://api.openweathermap.org/data/2.5/forecast?id=5061036&appid=02acf3eba1e20146f0800379e8cb831c&units=imperial', true);

forecastList.send();

forecastList.onload = function() {
    var forecastInfo = JSON.parse(forecastList.responseText);
    console.log(forecastInfo);

    document.getElementById('desc1').innerHTML = forecastInfo.list[4].weather[0].description;
    document.getElementById('hg1').innerHTML = forecastInfo.list[4].main.temp_max;
    document.getElementById('lw1').innerHTML = forecastInfo.list[4].main.temp_min;
    document.getElementById('wd1').innerHTML = forecastInfo.list[4].wind.speed;

    document.getElementById('desc2').innerHTML = forecastInfo.list[12].weather[0].description;
    document.getElementById('hg2').innerHTML = forecastInfo.list[12].main.temp_max;
    document.getElementById('lw2').innerHTML = forecastInfo.list[12].main.temp_min;
    document.getElementById('wd2').innerHTML = forecastInfo.list[12].wind.speed;
    
    document.getElementById('desc3').innerHTML = forecastInfo.list[20].weather[0].description;
    document.getElementById('hg3').innerHTML = forecastInfo.list[20].main.temp_max;
    document.getElementById('lw3').innerHTML = forecastInfo.list[20].main.temp_min;
    document.getElementById('wd3').innerHTML = forecastInfo.list[20].wind.speed;
    
    document.getElementById('desc4').innerHTML = forecastInfo.list[28].weather[0].description;
    document.getElementById('hg4').innerHTML = forecastInfo.list[28].main.temp_max;
    document.getElementById('lw4').innerHTML = forecastInfo.list[28].main.temp_min;
    document.getElementById('wd4').innerHTML = forecastInfo.list[28].wind.speed;
   
    document.getElementById('desc5').innerHTML = forecastInfo.list[36].weather[0].description;
    document.getElementById('hg5').innerHTML = forecastInfo.list[36].main.temp_max;
    document.getElementById('lw5').innerHTML = forecastInfo.list[36].main.temp_min;
    document.getElementById('wd5').innerHTML = forecastInfo.list[36].wind.speed;
}