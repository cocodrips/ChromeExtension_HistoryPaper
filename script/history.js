var apiUrl = "http://jlp.yahooapis.jp/MAService/V1/parse";
var appId = "dj0zaiZpPVNpT0xsWGc3ajEwVSZkPVlXazlTVm8zWVZsNk5Xa21jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MjI-";


$(function(){
    var start = "Apr 1, 2013";
     history(start);

});

var history = function(date){
    var start = Date.parse(date);
    var end = Date.parse(new Date());
    chrome.history.search({
            "text":"",
            "startTime":start,
            "endTime":end,
            "maxResults":100
        },
        function (array){
            var hashmap = create_map(array);
            export_urls(hashmap);
//            extract_keyword(hashmap);
//            extract_subject(hashmap);
        });

}

var create_map = function(array){
    var hashmap = new Array();
    for(var i in array){
        if(hashmap[array[i].id] == null){
            hashmap[array[i].id] = new Array();
            hashmap[array[i].id]["time"] = array[i].visitCount;
            hashmap[array[i].id]["url"] = array[i].url;
            hashmap[array[i].id]["title"] = array[i].title;
        }
    }
    return hashmap;
}

var export_urls = function(hashmap){
    var titles ="";
//    var re = new RegExp("?q=.+&");
    hashmap.forEach(function(e){
        if(e.url.indexOf("https://www.google.co.jp/search?") != -1){
            var q = e.url.match(/\?q=.*?\&/);
            if(q){
            q = decodeURI(q[0].replace(/\?q=(.*?)\&/,'$1'));
            q = q.split('+');
            titles += q + "<br>";
            }
        }
    });
//    console.log(hashmap);
    $("body").html(titles);
}

var extract_keyword = function(hashmap){
    var titles ="";
    hashmap.forEach(function(e){
        titles += e["title"]+ " ";
    });

    var params = new Array();
    params = {
        "appid":appId,
        "output":"json",
        "sentence":titles
    };

    $.getJSON(apiUrl+encodeUrl(params), function(json){
        console.log(json);
    });

}

var extract_subject = function(hashmap){
    var titles ="";
    hashmap.forEach(function(e){
        titles += e["title"]+ " ";
    });

    var params = new Array();
    params = {
        "appid":appId,
        "results":"uniq",
        "filter":"9",
        "sentence":titles
    };

    var xhttp = new XMLHttpRequest();
    xhttp.open("GET",apiUrl+encodeUrl(params),false);
    xhttp.send();
    var xmlDoc = xhttp.responseXML;
    var parser = new DOMParser();
    var dom = parser.parseFromString(xmlDoc, "text/xml");
    console.log(dom);
    var word = dom.getElementsByTagName("word");
    console.log(word);


    console.log(apiUrl+encodeUrl(params));
//    $.getJSON(apiUrl+encodeUrl(params), function(json){
//        console.log(json);
//    });

}

//
