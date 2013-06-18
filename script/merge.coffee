
merge = (list1, list2)->
  list = []
  i = 0
  j = 0
  while i != list.length and j != list2.length
    if list[i] < list[j]
      list.push list1[i]
      i++
    else
      list.push list2[j]
      j++
  while i != list1.length
    list.push list[i++]
  while j != list2.length
    list.push list[j++]


merge_sort = (list)->
  target_list = list

  i = 0
  while i < target_list.length-1
    list1 = target_list[i]
    list2 = target_list[i+1]

  console.log(target_list)

a = [0..100]
merge_sort(shuffle(a))