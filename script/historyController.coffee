$ ->
# Main
  now = new Date()
  start = Date.parse(new Date()) - 86400000;
  end = Date.parse(new Date());
  jsonData = ""

  chrome.history.search("text":"","startTime":start,"endTime":end,"maxResults":1000,
    (array)=>
      hashmap = new Hashmap(array)
      searchWordList(hashmap.hash)
      jsonData = new CreateData(hashmap.sortedByTimes())
      getJsonData.request(jsonData.urlList);
  )


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


class CreateData
  constructor: (hash)->
    @urlList = createJson(hash)
    return @urlList

  createJson = (hash)->
    count = 0
    urls = ""
    json = {
      name: "json"
      children: []
    }
    hash.forEach (h) =>
      elementNum = calcElementNum()
      if count < 6
        if canSelectPage(h)
          url = h.url.replace("http://","") + ","
          urls += url
          count++

    return urls

  calcElementNum = ()->
    width = $(window).width()
    height = $(window).height()
    s = width * height
    if s < 700000
      return 6
    else if s < 1500000
      return 8
    else
      return 12

  canSelectPage = (h)->
    if !@domainHash then @domainHash = []
    if h.url.indexOf("https") > -1
      return false

    if h.url.indexOf("http://") == -1
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
    if domainType == "localhost:8080"
      return false
    return true



