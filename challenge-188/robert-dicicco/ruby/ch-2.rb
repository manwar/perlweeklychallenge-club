#!/usr/bin/env ruby

=begin

AUTHOR: Robert DiCicco

DATE: 2022-10-25

Challenge 188 Total Zero ( Ruby )



You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:



$x = $x - $y if $x >= $y

or

$y = $y - $x if $y >= $x (using the original value of $x)

=end



$step = 0



def steps ( x, y )

  if ( x > y ) then

    x = x - y

  elsif (y > x ) then

    y = y - x

  end

  $step += 1

  if ( x == y) then

    $step += 1

    puts "Output: #{$step}";;

     puts " "

    return;

  end

  steps(x,y)

end



def main()

  g = [[5,4], [4,6], [2,5], [3,1], [7,4]];

  g.each do |f|

    x = f[0]

    y = f[1]

    puts("Input: $x = #{x},  $y = #{y}");

    $step = 0;

    steps(x,y)

  end

end



main()
