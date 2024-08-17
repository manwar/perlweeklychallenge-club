#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of positive integers, @ints.

Write a script to return the total number of elements in the given array which have the highest frequency.
Example 1

Input: @ints = (1, 2, 2, 4, 1, 5)
Ouput: 4

The maximum frequency is 2.
The elements 1 and 2 has the maximum frequency.

Example 2

Input: @ints = (1, 2, 3, 4, 5)
Ouput: 5

The maximum frequency is 1.
The elements 1, 2, 3, 4 and 5 has the maximum frequency.

=cut

use List::Util qw(max sum);
use Test2::V0;

is(max_freq(1, 2, 2, 4, 1, 5), 4, 'Example 1');
is(max_freq(1, 2, 3, 4, 5), 5, 'Example 2');
done_testing();

sub max_freq
{
     my @arr = @_;
     my %freq;
     do { $freq{$_}++ } for @arr;
     my $max_freq = max(values %freq);
     return sum(grep $_ == $max_freq, values %freq);
}