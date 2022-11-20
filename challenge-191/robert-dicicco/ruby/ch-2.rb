#!/usr/bin/env ruby



=begin

AUTHOR: Robert DiCicco

DATE: 2022-11-17

Challenge 191 Cute List ( Ruby )



You are given an integer, 0 < $n <= 15.



Write a script to find the number of orderings of numbers that form a cute list.



With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list is cute if for every entry, indexed with a base of 1, either



1) $list[$i] is evenly divisible by $i

or

2) $i is evenly divisible by $list[$i]



Example



Input: $n = 2

Ouput: 2



Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.

Therefore we can have two list i.e. (1,2) and (2,1).



@list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2 is divisible by 2.

=end



def main(n)

  arr = (1..n.to_i).to_a

  len = arr.length()

  puts "Input:  #{len}"

  arr.permutation(len).to_a.each do |suba|

    res = 0

    res2 = 0

    success = 0

    (0..len-1).each do |x|

      res = suba[x] % (x+1);

      res2 = (x+1) % suba[x];

      if ((res == 0) || (res2 == 0) )

        success += 1;

      end

      if (success == len)

        puts("\[#{suba}\] is cute!");

      end

    end

  end

  puts " "

end



for arg in ARGV

   #puts arg

   if (( arg.to_i < 1) || (arg.to_i > 15))

    puts "Error: supplied arg = #{arg}. arg must be greater than 0 and less than 16";

    exit;

   end

   main(arg)

end



=begin

SAMPLE OUTPUT



ruby .\CuteList.rb 2 3 4

Input:  2

[[1, 2]] is cute!

[[2, 1]] is cute!



Input:  3

[[1, 2, 3]] is cute!

[[2, 1, 3]] is cute!

[[3, 2, 1]] is cute!



Input:  4

[[1, 2, 3, 4]] is cute!

[[1, 4, 3, 2]] is cute!

[[2, 1, 3, 4]] is cute!

[[2, 4, 3, 1]] is cute!

[[3, 2, 1, 4]] is cute!

[[3, 4, 1, 2]] is cute!

[[4, 1, 3, 2]] is cute!

[[4, 2, 3, 1]] is cute!

=end
