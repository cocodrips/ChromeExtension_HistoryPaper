#require ['cs!hashmap'],
#(hashmap)->
#  console.log hashmap
#  @hashmap = new Hashmap

###
  memo
  どんな情報を知りたい？
  - bkmしてるページはもういつも見てるからいいんじゃないか。
  - 100回以上アクセスしたページとか。(どこがいる？)
###



$ ->
# Main
  now = new Date()
  start = Date.parse(new Date()) - 86400000;
  end = Date.parse(new Date());
  jsonData = ""


  #  求めたいもの
  chrome.history.search("text":"","startTime":start,"endTime":end,"maxResults":1000,
    (array)=>
      hashmap = new Hashmap(array)
      searchWord(hashmap.hash)
      jsonData = new CreateData(hashmap.sortedByTimes())
      getJsonData.request(jsonData.jsonFile);

#      hashmap.getData()
  )

#  setTimeout(()->
#    draw_treemap(jsonData)
#  ,200)
#
#  $(window).resize(()->
#    console.log "a"
#    draw_treemap(jsonData)
#  )

class Hashmap
  constructor:(hash)->
    @hash = create_hash(hash)
    @hashSortedByTimes = ""

  #  閲覧履歴のhashデータを生成
  create_hash = (array) ->
    hash = []
    for e in array
      id = e.id
      if !hash[id]
        hash[id] = {
          time:e.visitCount
          url:e.url
          title:e.title
        }
    return hash

  sortedByTimes: ()->
    sorted =  _.sortBy(@hash, (e)=>
      return e.time
    )
    @hashSortedByTimes = sorted
    return @hashSortedByTimes

  getData:()->
    $.ajax({
      type: 'POST'
      url: "http://itolabchica.appspot.com/hs/json"
      data: @hashSortedByTimes
      dataType:'json'
      success: (html)=>
        console.log html
    })

class CreateData
  constructor: (hash)->
    @jsonFile = createJson(hash)
    return @jsonFile

  createJson = (hash)->
    count = 0
    urls = ""
    json = {
      name: "json"
      children: []
    }
    hash.forEach (h) =>
      elementNum = 4
      if count < elementNum
        if pageCheck(h)
          url = h.url + ","
          console.log url
          urls += url

          count++

    return urls




  requestApi = (encoded) ->
    req = new XMLHttpRequest();
    req.open("GET", "http://itolabchica.appspot.com/hs/pageinfo/"+encoded, true)
    req.onload = showTest(this);
    req.send(null);

  showTest = (e)->
    console.log "status" + e.target.status
    console.log "response:" + e.target.responseText



  calcElementNum = ()->
    width = $(window).width()
    height = $(window).height()
    s = width * height
    if s < 700000
      return 4
    else if s < 1500000
      return 6
    else
      return 8


  calcDataSize = (val)->
    size = if val < 100
      10
    else
      50
    return size

  pageCheck = (h)->
    if !@domainHash then @domainHash = []
    if h.url.indexOf("https") > -1
      return false

    if h.title.length < 2
      return false

    pageType = h.url.split("/").pop()
    target = ["png", "jpg", "mp3"]
    for t in target
      if pageType.indexOf(t) != -1
        return false

    domainType = h.url.split("/")[2]
    if !@domainHash[domainType]
      @domainHash[domainType] = true
    else
      return false

    if domainType == "www.youtube.com"
      return false
    if domainType == "127.0.0.1:5000"
      return false

    return true

#  openURI = (url)->
#    encoded = encodeURIComponent(url)
#    $.ajax({
#      type: 'GET'
#      url: "http://itolabchica.appspot.com/hs/pageinfo/" + encoded
#      dataType:'document'
#      success: (json)=>
#        console.log json
#    })




class ExtractPageData
  constructor: (url)->
    @requestUrl = url
    openURI(@requestUrl)

  openURI = (url)->
    encoded = encodeURIComponent(url)
#    $.ajax({
#      type: 'POST'
#      url: "http://itolabchica.appspot.com/hs/pageinfo" + encoded
#      data:
#      dataType:'json'
#      success: (html)=>
#        console.log html
##        createDom(html)
#    })

  createDom = (html)->
#    console.log html.getElementsByTagName('img')


#クラス必要ないやつ
searchWord = (hashmap)->
  titles = []
  hashmap.forEach(
    (page)=>
      if page.url.indexOf("https://www.google.co.jp/search?") != -1
        q = page.url.match /\?q=.*?\&/
        if q
          q = decodeURI q[0].replace /\?q=(.*?)\&/,'$1'
          q = q.split /[\s,\+]+/
          q.forEach(
            (title)=>
              if !titles[title]
                titles[title] = 1
              else
                titles[title] += 1
          )
  )
  console.log titles

  tag = ""
  console.log "key"
  for key in titles
    console.log






