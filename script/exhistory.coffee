apiUrl = "http://jlp.yahooapis.jp/MAService/V1/parse";
appId = "dj0zaiZpPVNpT0xsWGc3ajEwVSZkPVlXazlTVm8zWVZsNk5Xa21jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MjI-";


$ ->
  now = new Date()
  time = now.getHours()+":"+now.getMinutes()
  $('body').html(time)

  start = Date.parse("Apr 1, 2013");
  end = Date.parse(new Date());

  chrome.history.search("text":"","startTime":start,"endTime":end,"maxResults":100,
    (array)=>
      hashmap = create_map array
      search_word hashmap
      top_article hashmap
  )



create_map = (array) ->
  hashmap = []
  for e in array
    id = e.id
    if !hashmap[id]
      hashmap[id] = {
        time:e.visitCount
        url:e.url
        title:e.title
      }
  return hashmap

top_article = (hashmap)->
  sorted_hash =  _.sortBy(hashmap, (e)=>
    return e.time
  )
  sorted_hash.reverse()
  console.log sorted_hash


search_word = (hashmap)->
  titles = ""
  hashmap.forEach(
    (page)=>
      if page.url.indexOf("https://www.google.co.jp/search?") != -1
        q = page.url.match /\?q=.*?\&/
        if q
          q = decodeURI q[0].replace /\?q=(.*?)\&/,'$1'
          q = q.split /[\s,\+]+/
          q.forEach(
            (title)=>
              titles += title + " "
          )
          titles += "<br>"
    )
  $('body').html(titles)






