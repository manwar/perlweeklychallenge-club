#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.

Write a script to sort odd index elements in decreasing order and even index elements in increasing order in the given array.
Example 1

Input: @ints = (4, 1, 2, 3)
Output: (2, 3, 4, 1)

Even index elements: 4, 2 => 2, 4 (increasing order)
Odd index elements : 1, 3 => 3, 1 (decreasing order)

Example 2

Input: @ints = (3, 1)
Output: (3, 1)

Example 3

Input: @ints = (5, 3, 2, 1, 4)                                               
Output: (2, 3, 4, 1, 5)                                                       
                                                                           
Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)                   
Odd index elements : 3, 1 => 3, 1 (decreasing order)  
=cut


use Test2::V0 -no_srand => 1;
is(sort_odd_even(4, 1, 2, 3), [2, 3, 4, 1], 'Example 1');
is(sort_odd_even(3, 1), [3, 1], 'Example 2');
is(sort_odd_even(5, 3, 2, 1, 4), [2, 3, 4, 1, 5], 'Example 3');
done_testing();

sub sort_odd_even
{
     my @arr = @_;
     my %even = map { $_ => $arr[$_] }  grep { $_ % 2 == 0 } 0 .. $#arr;
     my %odd  = map { $_ => $arr[$_] }  grep { $_ % 2 == 1 } 0 .. $#arr;
     @arr[sort {$a <=> $b} keys %even] = sort { $a <=> $b } values %even;
     @arr[sort {$a <=> $b} keys %odd ] = sort { $b <=> $a } values %odd;
     return [@arr];
}
