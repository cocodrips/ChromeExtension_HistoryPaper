define(["jquery"] , -> return new Hashmap())

class Hashmap
  constructor: ()->
    console.log "test"

  #  閲覧履歴のhashデータを生成
  create_hash = (array) ->
    hash = []
    for e in array
      id = e.id
      if !hashmap[id]
        hashmap[id] = {
          time:e.visitCount
          url:e.url
          title:e.title
        }
    @hash = hash

  #  hashmapを訪問回数順に並べる
  sorted_by_times = ()->
    sorted_hash =  _.sortBy(@hash, (e)=>
      return e.time
    )
    sorted_hash.reverse()
    return sorted_hash

  #  検索したワードの抽出
#  search_word = (hashmap)->
#    titles = ""
#    hashmap.forEach(
#      (page)=>
#        if page.url.indexOf("https://www.google.co.jp/search?") != -1
#          q = page.url.match /\?q=.*?\&/
#          if q
#            q = decodeURI q[0].replace /\?q=(.*?)\&/,'$1'
#            q = q.split /[\s,\+]+/
#            q.forEach(
#              (title)=>
#                titles += title + " "
#            )
#            titles += "<br>"
#    )
#    $('body').html(titles)



