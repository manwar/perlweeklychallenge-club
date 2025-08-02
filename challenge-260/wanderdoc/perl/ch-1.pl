#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers, @ints. Write a script to return 1 if the number of occurrences of each value in the given array is unique or 0 otherwise.
Example 1 Input: @ints = (1,2,2,1,1,3) Output: 1
The number 1 occurred 3 times.
The number 2 occurred 2 times.
The number 3 occurred 1 time.

All occurrences are unique, therefore the output is 1.

Example 2 Input: @ints = (1,2,3) Output: 0
Example 3 Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9) Output: 1
=cut

use Test2::V0;

is(unique_occurences(1,2,2,1,1,3), 1, 'Example 1');
is(unique_occurences(1,2,3), 0, , 'Example 2');
is(unique_occurences(-2,0,1,-2,1,1,0,1,-2,9), 1, 'Example 3');
done_testing();

sub unique_occurences
{
     my @arr = @_;
     my %values;
     do { $values{$_}++ } for @arr;
     my %unique;
     @unique{values %values} = undef;
     return (scalar keys %unique == scalar keys %values) ? 1 : 0;
}
