
var getJsonData = {
  request: function(urls) {
    var req = new XMLHttpRequest();
    console.log(urls);
    url = "http://www25463ue.sakura.ne.jp/chica/web.wsgi/hs/pageinfo/"+ encodeURI(urls);
    console.log(url);
    req.open("GET", url, true);
    req.onload = this.showData_.bind(this);
    req.send(null);
//
  },

  showData_: function (e) {
      console.log("status " + e.target.status);
      console.log("response " + e.target.responseText);
      res = $.parseJSON(e.target.responseText);
      console.log(res);
      draw_treemap(res)
  }

};


function encode(string, encoding) {
    encoding = encoding || "UTF-8";
    if(typeof Buffer === "function") {
        return new Buffer(string, encoding);
    } else {
        var bytes = [];
        var cs = encodeURI(string).match(/(?:%[0-9A-F]{2})|./g);
        for(var i = 0, len = cs.length; i < len; i++) {
            if(cs[i].length === 3) {
                bytes.push(parseInt(cs[i].slice(1), 16));
            } else {
                bytes.push(cs[i].charCodeAt(0));
            }
        }
        return bytes;
    }
}

function decode(bytes, encoding) {
    encoding = encoding || "UTF-8";
    if(typeof Buffer === "function") {
        return bytes.toString(encoding);
    } else {
        var encoded = "";
        for(var i = 0, len = bytes.length; i < len; i++) {
            encoded += "%" + bytes[i].toString(16);
        }
        return decodeURIComponent(encoded);
    }
}
