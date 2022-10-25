#!usr/bin/perl -w
use strict;
use warnings;

use feature qw(say signatures);
no warnings qw(experimental);

# Task 2: Total Zero

# You are given two positive integers $x and $y.

# Write a script to find out the number of operations needed to make both ZERO. Each operation is made up either of the followings:  
    # $x = $x - $y if $x >= $y
# or
    # $y = $y - $x if $y >= $x (using the original value of $x)


sub totalZero($x, $y)
{
    my $steps = 0;

    while(not (($x == 0) && ($y == 0)))
    {
        my $tempX = $x;
        my $tempY = $y;
        
        if($x >= $y)
        {
            $tempX -= $y;
        }
        
        if($y >= $x)
        {
            $tempY -= $x;
        }
        
        $x = $tempX;
        $y = $tempY;
        $steps++;
        
    }
    say($steps);

}


# Examples:
# totalZero(5,4); # 5
# totalZero(4,6); # 3
# totalZero(2,5); # 4
# totalZero(3,1); # 3
# totalZero(7,4); # 5