#!usr/bin/perl -w
use strict;
use warnings;

use feature qw(say signatures);
no warnings qw(experimental);

use Algorithm::Combinatorics qw(variations);


# Task 1: Divisible Pairs

# You are given list of integers @list of size $n and divisor $k.
# Write a script to find out count of pairs in the given list that satisfies the following rules.

# The pair (i, j) is eligible if and only if
# a) 0 <= i < j < len(list)
# b) list[i] + list[j] is divisible by k

sub pairs($divisor, @array)
{
    my $count = 0;
    my @indexArray = (0..(@array-1));

    foreach my $elem (variations( \@indexArray, 2))
    {
        my $i = @$elem[0];
        my $j = @$elem[1];

        if( (0 <= $i < $j) && (($array[$i] + $array[$j]) % $divisor == 0 ))
        {   
            $count++;
        }
    }
    say($count);
}


# Examples:

my  @testList0 = (4, 5, 1, 6);
my  $k0        = 2;
pairs($k0, @testList0);
# Output: 2

my  @testList1 = (1, 2, 3, 4);
my  $k1        = 2;
pairs($k1, @testList1);
# Output: 2

my  @testList2 = (1, 3, 4, 5);
my  $k2        = 3;
pairs($k2, @testList2);
# Output: 2

my  @testList3  = (5, 1, 2, 3);
my  $k3         = 4;
pairs($k3, @testList3);
# Output: 2

my  @testList4  = (7, 2, 4, 5);
my  $k4         = 4;
pairs($k4, @testList4);
# Output: 1