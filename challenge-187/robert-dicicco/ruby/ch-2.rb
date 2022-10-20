#!/usr/bin/env ruby

# AUTHOR: Robert DiCicco

# DATE: 2022-10-20

# Challenge 187 Magical Triplets ( Ruby )



arr = [[1,2,3,2],[1,3,2],[1,1,2,3],[2,4,3]]



arr.each do |x|

  maxnum = 0;

  x.permutation(3) do |item|

    n = (item.join).to_i

    if n > maxnum

      maxnum = n

    end

  end

  a,b,c = maxnum.to_s.split(//)

  a = a.to_i

  b = b.to_i

  c = c.to_i

  if ((a+b)>c) && ((b+c)>a) && ((a+c>b))

    puts("Input @n = #{x}")

    puts("Output: [#{a}, #{b}, #{c}]")

    puts(" ")

  else

    puts("Input @n = #{x}")

    puts("Output: []")

    puts(" ")

  end

end
