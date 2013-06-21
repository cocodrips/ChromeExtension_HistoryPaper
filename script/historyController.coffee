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
  start = Date.parse(new Date()) - 8640000;
  end = Date.parse(new Date());
  jsonData = ""


  #  求めたいもの
  chrome.history.search("text":"","startTime":start,"endTime":end,"maxResults":100,
    (array)=>
      hashmap = new Hashmap(array)
      jsonData = new CreateData(hashmap.sortedByTimes())
  )

  setTimeout(()->
    console.log jsonData
    draw_treemap(jsonData)
  ,200)

class Hashmap
  constructor:(hash)->
    @hash = create_hash(hash)
    @hashSortedByTimes = null

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

  sortedByTimes:()->
    if @hashSortedByTimes
      return @hashSortedByTimes
    else
      sorted =  _.sortBy(@hash, (e)=>
        return e.time
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
                size: calcDataSize h.time
                url: h.url
                articleId: "article"+count
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





