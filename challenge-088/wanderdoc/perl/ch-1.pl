#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers @N.Write a script to return an array @M where $M[i] is the product of all elements of @N except the index $N[i].
Example 1: Input: @N = (5, 2, 1, 4, 3) Output: @M = (24, 60, 120, 30, 40)
Example 2: Input: @N = (2, 1, 4, 3) Output: @M = (12, 24, 6, 8)
=cut









use List::Util qw(reduce);
use Test::More;
is_deeply([aop(5, 2, 1, 4, 3)], [24, 60, 120, 30, 40], 'Example 1');
is_deeply([aop(   2, 1, 4, 3)], [12, 24, 6, 8],        'Example 2');
done_testing();




sub aop
{
     my @arr = @_;
     my @aop = map { my $n = $_; 
                    reduce { $a * $b } @arr[grep { $_ != $n } 0 .. $#arr] } 
               0 .. $#arr;
     return @aop;
}