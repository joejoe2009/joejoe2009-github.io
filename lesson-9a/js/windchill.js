function doInputOutput() {
    var tempF = parseFloat(document.getElementById('tempFInputBox').value);
    var speed =  parseFloat(document.getElementById('speedInputBox').value);
    var result = windChill(tempF, speed);
    document.getElementById('outputDiv').innerHTML = result;
}

function windChill(tempF, speed) { 
return   35.74 + 0.6215 * tempF - 35.75 * Math.pow(speed, 0.16) + 0.4275 * tempF * Math.pow(speed, 

0.16);
}