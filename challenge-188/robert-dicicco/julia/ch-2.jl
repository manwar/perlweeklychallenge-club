#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE: 2022-10-25

Challenge 188 Total Zero ( Julia )



You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:



$x = $x - $y if $x >= $y

or

$y = $y - $x if $y >= $x (using the original value of $x)

=#



using Printf



arr = [[5,4], [4,6], [2,5], [3,1], [7,4]];



step = 0;



function steps( x, y)

  if ( x > y )

    x = x - y

  elseif (y > x )

    y = y - x

  end

  global step += 1

  if ( x == y)

    step += 1

    @printf("Output: %d\n\n", step);

    return;

  end

  steps(x,y)

end



for f in arr

  x = f[1]

  y = f[2]

  @printf("Input: x = %d, y = %d\n", x,y);

  global step = 0

  steps(x,y)

end
