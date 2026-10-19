#!/usr/bin/env regina

say finishing_order('3 1 4 2 5','1 2 4')
say finishing_order('5 4 3 2 1','1 3 5')
say finishing_order('2 4 1 3','1 2 3 4')
say finishing_order('4 1 3 2','3')
say finishing_order('1 3 2 6 5 4','1 2 3')

exit 0

finishing_order: procedure
  parse arg a,b
  h. = 0
  do i = 1 to words(b)
    k = word(b,i)
    h.k = 1
  end
  res = ''
  do i = 1 to words(a)
    k = word(a,i)
    if h.k then res = res k
  end
  return strip(res)
