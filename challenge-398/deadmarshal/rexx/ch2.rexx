#!/usr/bin/env regina

say string_difference('ab bc cd zy')
say string_difference('cba fed azy')
say string_difference('pop ada beb cfc')
say string_difference('aaaa zzzz mmmm aaba')
say string_difference('aceg bdfh cegi azbz')

exit

string_difference: procedure
  parse arg list
  h. = 0
  n = words(list)

  do i = 1 to n
    w = word(list,i)
    key = ''
    do j = 1 to length(w)-1
      d = c2d(substr(w,j+1,1)) - c2d(substr(w,j,1))
      if j < 1 then key = key || ','
      key = key || d
    end
    keys.i = 'k' || key
    k = keys.i
    h.k = h.k + 1
  end

  do i = 1 to n
    k = keys.i
    if h.k = 1 then return word(list,i)
  end
  return -1
