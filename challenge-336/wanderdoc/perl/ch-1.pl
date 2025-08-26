#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers.
Write a script to return true if the given array can be divided into one or more groups of same size such that each group has two or more members having same value.

Example 1

Input: @ints = (1,1,2,2,2,2)
Output: true

Groups: (1,1), (2,2), (2,2)


Example 2

Input: @ints = (1,1,1,2,2,2,3,3)
Output: false

Groups: (1,1,1), (2,2,2), (3,3)


Example 3

Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
Output: true

Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)


Example 4

Input: @ints = (1,2,3,4)
Output: false


Example 5

Input: @ints = (8,8,9,9,10,10,11,11)
Output: true

Groups: (8,8), (9,9), (10,10), (11,11)
=cut




use List::Util qw(min first);
use constant { true => 1, false => 0 };

use Test2::V0 -no_srand => 1;

is(equal_group(1,1,2,2,2,2), true, 'Example 1');
is(equal_group(1,1,1,2,2,2,3,3), false, 'Example 2');
is(equal_group(5,5,5,5,5,5,7,7,7,7,7,7), true, 'Example 3');
is(equal_group(1,2,3,4), false, 'Example 4');
is(equal_group(8,8,9,9,10,10,11,11), true, 'Example 5');
done_testing();


sub equal_group
{
     my @arr = @_;
     @arr = sort {$a <=> $b} @arr;
     my %freq;
     $freq{$_}++ for @arr;
     my @slots = values %freq;
     my $max_size = min(@slots);
     return false if $max_size < 2;
     return false if defined first { $_ % $max_size != 0 } @slots;
     return true;
     
}
