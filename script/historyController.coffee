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
  now = new Date()
  time = now.getHours()+":"+now.getMinutes()
#  $('body').html(time)

  start = Date.parse("Apr 1, 2013");
  end = Date.parse(new Date());

  chrome.history.search("text":"","startTime":start,"endTime":end,"maxResults":100,
    (array)=>
      hashmap = new Hashmap(array)
      console.log hashmap.sorted_by_times()
#      hashmap = create_map array
#      search_word hashmap
#      sorted_hash = top_article hashmap
  )


class Hashmap
  constructor: (array)->
    @hash = create_hash array
    @hash_sorted_by_times = null;

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
    @hash = hash

  #  hashmapを訪問回数順に並べる
  sorted_by_times:()->
    if @hash_sorted_by_times
      return @hash_sorted_by_times
    else
      sorted =  _.sortBy(@hash, (e)=>
        return e.time
      )
      @hash_sorted_by_times = sorted.reverse()
    return @hash_sorted_by_times


