#!/usr/bin/env regina

say trionic_array('1 3 5 4 2 6 8')
say trionic_array('1 4 4 2 1 3 5')
say trionic_array('2 10 3 1 9')
say trionic_array('1 2 3 4 3 2 1')
say trionic_array('1 3 6 4 2 7 8 4')

exit 0

trionic_array: procedure
  parse arg a
  n = words(a)
  p = 0
  do while p < n - 2
    if word(a,p+1) < word(a,p+2) then p = p + 1
    else leave
  end
  if p = 0 then return 0
  q = p
  do while q < n - 1
    if word(a,q+1) > word(a,q+2) then q = q + 1
    else leave
  end
  if q = p | q = n - 1 then return 0
  do while q < n - 1
    if word(a,q+1) < word(a,q+2) then q = q + 1
    else leave
  end
  return q = n - 1
