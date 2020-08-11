#!/usr/bin/perl

# Create a function to check divide by zero error without checking if the denominator is zero.

use strict;
use warnings;

sub divide_with_zero_check{

    my ($num,$den) = @_;

    return eval { $num / $den } // $@;

}

# print divide_with_zero_check(10,5); # 2
# print divide_with_zero_check(10,0); # Illegal division by zero
# print divide_with_zero_check(15,0); # Illegal division by zero
# print divide_with_zero_check(15,3); # 5
