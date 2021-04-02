#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers @N. Write a script to display the maximum difference between two successive elements once the array is sorted. If the array contains only 1 element then display 0.
Example
Input: @N = (2, 9, 3, 5) Output: 4
Input: @N = (1, 3, 8, 2, 0) Output: 5
Input: @N = (5) Output: 0
=cut





use List::Util qw(max);
use Test::More;


sub max_gap
{
     my @arr = @_;
     return 0 if scalar @arr < 2;
     @arr = sort {$b <=> $a} @arr;

     my $gap = max( map { $arr[$_] - $arr[$_ + 1] } 0 .. $#arr - 1 );
     return $gap;
}


is(max_gap(2, 9, 3, 5), 4, 'Example 1');
is(max_gap(1, 3, 8, 2, 0), 5, 'Example 2');
is(max_gap(5), 0, 'Example 3');

done_testing();