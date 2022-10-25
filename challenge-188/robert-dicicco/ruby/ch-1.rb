#!/usr/bin/env ruby

=begin

 AUTHOR: Robert DiCicco

DATE: 2022-10-24

Challenge 188 Divisible Pairs  ( Ruby )



You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list that satisfies the following rules.



The pair (i, j) is eligible if and only if

a) 0 <= i < j < len(list)

b) list[i] + list[j] is divisible by k

=end



arr = [[4, 5, 1, 6], [1, 2, 3, 4],[1, 3, 4 ,5], [5, 1, 2, 3], [7, 2, 4, 5]]

ks =[2,2,3,4,4]

cnt = 0

out = []

val = []

subcnt = 0



arr.each do |nd|

  print "Input: \@list = \[#{nd}\], \k = #{ks[cnt]}\n" ;

  nd.permutation(2) do |item|

    i = item[0]

    j = item[1]

    k = ks[cnt]

    sz = nd.length()

    if ( (i < j) && ((i + j) % k == 0)  ) then

      out.push(i,j)

      subcnt += 1

    end

  end

  puts("Output: #{subcnt}")

  subcnt = 0

  out = []

  cnt += 1

end
