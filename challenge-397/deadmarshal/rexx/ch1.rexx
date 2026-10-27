say absent_smallest_positive('1 2 4 5 6')
say absent_smallest_positive('-5 -2 -1 3')
say absent_smallest_positive('1 2 3')
say absent_smallest_positive('2 3 7 8')
say absent_smallest_positive('1 1 1 10')

exit 

absent_smallest_positive: procedure
  parse arg arr
  n = words(arr)
  sum = 0
  h. = 0

  do i = 1 to n
    e = word(arr,i) + 0
    h.e = 1 
    sum = sum + e
  end
  ret = max(1,sum % n + 1)
  do while h.ret = 1 
    ret = ret + 1
  end
  return ret
