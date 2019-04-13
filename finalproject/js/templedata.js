var section = document.querySelector('section');
var requestURL = 'https://joejoe2009.github.io/finalproject/directory/templedata.json';
var request = new XMLHttpRequest();
request.open('GET', requestURL);

request.responseType = 'json';
request.send();

request.onload = function () {

    var temples = request.response;
    showTemples(temples);
    temples.names;
    temples['active'];
}

function showTemples(jsonObj) {

    var templeObj = jsonObj['temples'];

    for (var i = 0; i < templeObj.length; i++) {

        if (templeObj[i].name == "Aba Nigeria Temple" || templeObj[i].name == "Accra Ghana Temple" || templeObj[i].name == "Adelaide Australia Temple" || templeObj[i].name == "Albuquerque New Mexico Temple") {

            var myArticle = document.createElement('article');
            var myH2 = document.createElement('h2');
            var myPara1 = document.createElement('p');
            var myPara2 = document.createElement('p');
            var myPara3 = document.createElement('p');
            var myPara4 = document.createElement('p');
            var myPara5 = document.createElement('p');
            var myPara6 = document.createElement('p');
            var myPara7 = document.createElement('p');
            var myPara8 = document.createElement('p');
            var myImg = document.createElement('img');

            if (templeObj[i].name == "Aba Nigeria Temple") {
                myImg.setAttribute('src', 'https://assets.ldscdn.org/5b/c8/5bc8d6bd3395a49eb9bfc547095418a43572f566/aba_nigeria_temple_lds.jpg');
                myImg.setAttribute('alt', 'Aba Nigeria Temple Image');
            } else if (templeObj[i].name == "Accra Ghana Temple") {
                myImg.setAttribute('src', 'https://assets.ldscdn.org/09/62/0962f6d10c379153f4bcb4a872f8c1c3ff027ff3/accra_ghana_temple_lds.jpg');
                myImg.setAttribute('alt', 'Accra Ghana Temple');
            } else if (templeObj[i].name == "Adelaide Australia Temple") {
                myImg.setAttribute('src', 'https://assets.ldscdn.org/8e/8e/8e8e9429f0423c418b66b9a9b61a3de734d9ac6c/adelaide_australia_temple.jpg');
                myImg.setAttribute('alt', 'Adelaide Australia Temple');
            } else if (templeObj[i].name == "Albuquerque New Mexico Temple") {
                myImg.setAttribute('src', 'https://assets.ldscdn.org/a7/42/a74255ed09c750b7b79c5c71c6c3368f50463e19/albuquerque_temple_lds.jpg');
                myImg.setAttribute('alt', 'Adelaide Australia Temple');
            }

            myH2.textContent = templeObj[i].name;
            myPara1.textContent = templeObj[i].address;
            myPara2.textContent = "Telephone: " + templeObj[i].telephone;
            myPara3.textContent = "Email: " + templeObj[i].email;
            myPara4.textContent = "Services: " + templeObj[i].services;
            myPara5.textContent = "History: " + templeObj[i].history;
            myPara6.textContent = "OrdinanceSchedule: " + templeObj[i].ordinanceSchedule;
            myPara7.textContent = "SessionSchedule: " + templeObj[i].sessionSchedule;
            myPara8.textContent = "TempleClosure: " + templeObj[i].templeClosure;

            myArticle.appendChild(myH2);
            myArticle.appendChild(myPara1);
            myArticle.appendChild(myPara2);
            myArticle.appendChild(myPara3);
            myArticle.appendChild(myPara4);
            myArticle.appendChild(myPara5);
            myArticle.appendChild(myPara6);
            myArticle.appendChild(myPara7);
            myArticle.appendChild(myPara8);
            myArticle.appendChild(myImg);

            section.appendChild(myArticle);
        }
    }
}