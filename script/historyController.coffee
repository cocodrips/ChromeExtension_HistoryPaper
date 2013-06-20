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
  time = now.getHours()+":"+now.getMinutes()
  start = Date.parse(new Date()) - 8640000;
  comparisonStart = Date.parse(new Date()) - 60480000;
  end = Date.parse(new Date());
  hash = new Hashmap

  #  tf-idf的なものを調べるため
  chrome.history.search("text":"","startTime":comparisonStart,"endTime":start,"maxResults":7000,
    (array)=>
      hash.create_idfhash(array)
  )

  #  求めたいもの
  chrome.history.search("text":"","startTime":start,"endTime":end,"maxResults":1000,
    (array)=>
      hash.create_tfhash(array)
  )

  setTimeout(()->
    jsonData = new CreateData(hash.sortedByTimes())
    draw_treemap(jsonData)
  ,200)

class Hashmap
#  constructor: (array)->
  @hash = null
  @idfhash = null
  @hashSortedByTimes = null

  #  閲覧履歴のhashデータを生成
  create_tfhash: (array) ->
    if !@idfhash then return null
    hash = []
    for e in array
      id = e.id
#      idf =  if @idfhash[id] then @idfhash[id] else 1
      idf = if @idfhash[id] then false else true
      if !hash[id]
        hash[id] = {
          time:e.visitCount
#          priority: p = if e.visitCount / idf then e.visitCount / idf else 1
          priority: p = if idf then 100 else e.visitCount
          url:e.url
          title:e.title
        }
    @hash = hash

  create_idfhash: (array) ->
    hash = []
    for e in array
      id = e.id
      if !hash[id]
        hash[id] = {
          time:e.visitCount
          url:e.url
          title:e.title
        }
    @idfhash = hash

  #  hashmapを訪問回数順に並べる
  sortedByTimes:()->
    if @hashSortedByTimes
      return @hashSortedByTimes
    else
      sorted =  _.sortBy(@hash, (e)=>
        return e.priority
      )
      @hashSortedByTimes = sorted
    return @hashSortedByTimes

class CreateData
  constructor: (hash)->
    @jsonFile = createJson(hash)
    return @jsonFile

  createJson = (hash)->
    count = 0
    json = {
      name: "json"
      children: []
    }

    hash.forEach (h) =>
      elementNum = 10 #どこかで定数として定義したい
      if count < elementNum
        if pageCheck(h)
          group = {
            name:h.title
            children:[
              {
                name: h.title
                size: calcDataSize h.priority
                url: h.url
#                json: openURI(h.url)
              }
            ]
          }
          ex = new ExtractPageData(h.url)
          json.children.push group
          count++
    return json

  calcDataSize = (val)->
    size = if val < 100
      10
    else
      50
    return size

  pageCheck = (h)->
#    ssh除去
    if h.url.indexOf("https") > -1
      return false
    return true

  openURI = (url)->
    encoded = encodeURIComponent(url)
    $.ajax({
      type: 'GET'
      url: "http://itolabchica.appspot.com/hs/pageinfo/" + encoded
      dataType:'document'
      success: (json)=>
        console.log json
    })




class ExtractPageData
  constructor: (url)->
    @requestUrl = url
    openURI(@requestUrl)

  openURI = (url)->
    encoded = encodeURIComponent(url)
#    $.ajax({
#      type: 'GET'
#      url: "http://itolabchica.appspot.com/hs/pageinfo" + encoded
#      dataType:'document'
#      success: (html)=>
#        console.log html
##        createDom(html)
#    })

  createDom = (html)->
#    console.log html.getElementsByTagName('img')





