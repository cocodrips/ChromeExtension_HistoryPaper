
var getJsonData = {
  request: function(urls) {
    var req = new XMLHttpRequest();
    console.log(urls);
    url = "http://www25463ue.sakura.ne.jp/chica/web.wsgi/hs/pageinfo/"+ encodeURI(urls);
    console.log(url);
    req.open("GET", url, true);
    req.onload = this.showData_.bind(this);
    req.send(null);
    getJsonData.test()
//
  },

  showData_: function (e) {
      console.log("status " + e.target.status);
      console.log("response " + e.target.responseText);
      res = $.parseJSON(e.target.responseText);
      console.log(res);
      draw_treemap(res)
  },
  test: function(){
      var a = new Object();
      a['あ'] = "a";
      a['い'] = "i";
      console.log(a);


      for(var i in a){
          console.log(i + ":" +a[i]);
      }
  }

};

