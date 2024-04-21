#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints.

Write a script to find an integer in the given array that appeared 33% or more. If more than one found, return the smallest. If none found then return undef.
Example 1

Input: @ints = (1,2,3,3,3,3,4,2)
Output: 3

1 appeared 1 times.
2 appeared 2 times.
3 appeared 4 times.

3 appeared 50% (>33%) in the given array.

Example 2

Input: @ints = (1,1)
Output: 1

1 appeared 2 times.

1 appeared 100% (>33%) in the given array.

Example 3

Input: @ints = (1,2,3)
Output: 1

1 appeared 1 times.
2 appeared 1 times.
3 appeared 1 times.

Since all three appeared 33.3% (>33%) in the given array.
We pick the smallest of all.
=cut


use Test2::V0;
use List::Util qw(sum);





is(appearance_33(1,2,3,3,3,3,4,2), 3, 'Example 1');
is(appearance_33(1,1), 1, 'Example 2');
is(appearance_33(1,2,3), 1, 'Example 3');
done_testing();

sub appearance_33
{
     my @arr = @_;
     my %hash;
     do { $hash{$_}++ } for @arr;
     my $sum = sum(values %hash);
     my @output = 
          sort { $a cmp $b }
          grep { $hash{$_} > 33 * $sum / 100 } keys %hash;
     
     return $output[0];
}