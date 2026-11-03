#!/usr/bin/env regina

say divisible_average('18 5 7 11')
say divisible_average('6 12 18 24 30 40')
say divisible_average('3 9 15 21 27')
say divisible_average('6 12 14 20')
say divisible_average('6 6 6 12 12')

exit

divisible_average: procedure
  parse arg nums
  sum = 0
  cnt = 0
  do i = 1 to words(nums)
    n = word(nums,i)
    if n // 2 = 0 & n // 3 = 0 then do
      sum = sum + n
      cnt = cnt + 1
    end
  end
  if cnt = 0 then return 0
  return sum % cnt
