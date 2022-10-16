#!usr/bin/perl -w
use strict;
use warnings;

use feature ('say', 'signatures');
no  warnings 'experimental';

# Challange 186 - 1 - Zip List
# You are given two list @a and @b of same size.

# Create a subroutine sub zip(@a, @b) that merge the two list as shown in the example below.

# Input:  @a = qw/1 2 3/; @b = qw/a b c/;

# Output:   zip(@a, @b) should return qw/1 a 2 b 3 c/;
#           zip(@b, @a) should return qw/a 1 b 2 c 3/;
        
# my @arr1 =  qw/1 2 3/;
# my @arr2 =  qw/a b c/;

# zip(\@arr1, \@arr2);
# zip(\@arr2, \@arr1);

sub zip($a, $b)
{
    my @a = @{$a};
    my @b = @{$b};
    
    my @result;
    
    while(@a > 0)   # since both arrays are of the same length I can do this.
    {
        push(@result, shift(@a));
        push(@result, shift(@b));
    }

    say(join(' ',@result));
}