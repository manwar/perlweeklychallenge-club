#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of n integers.
Write a script to find all the missing integers in the range 1..n in the given array.

Example 1

Input: @ints = (1, 2, 1, 3, 2, 5)
Output: (4, 6)

The given array has 6 elements.
So we are looking for integers in the range 1..6 in the given array.
The missing integers: (4, 6)


Example 2

Input: @ints = (1, 1, 1)
Output: (2, 3)


Example 3

Input: @ints = (2, 2, 1)
Output: (3)


Example 4

Input: @ints = (2, 1)
Output: ()
=cut





use Test2::V0 -no_srand => 1;
is( [missing_integers(1, 2, 1, 3, 2, 5)], [4, 6], 'Example 1');
is( [missing_integers(1, 1, 1)], [2, 3], 'Example 2');
is( [missing_integers(2, 2, 1)], [3], 'Example 3');
is( [missing_integers(2, 1)], [], 'Example 1');
done_testing();

sub missing_integers
{
     my @arr = @_;
     my %lookup = map {$_ => undef} @arr;
     return grep { not exists $lookup{$_} } 1 .. @arr;
}
