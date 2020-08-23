#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers of size $N. Write a script to find the majority element. If none found then print -1.
Majority element in the list is the one that appears more than floor(size_of_list/2).

Example 1: Input: @A = (1, 2, 2, 3, 2, 4, 2) Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).
Example 2: Input: @A = (1, 3, 1, 2, 4, 5) Output: -1 as none of the elements appears more than floor(6/2).
=cut





use List::Util qw(first);
use Test::More;


sub majority
{
     my @array = @_;
     my $level = int((scalar @array)/2);
     my %count;

     $count{$_}++ for @array;
     return (first { $count{$_} > $level } keys %count) // -1;
}

is(majority(1, 2, 2, 3, 2, 4, 2), 2, 'Example 1');
is(majority(1, 3, 1, 2, 4, 5), -1,   'Example 2');
done_testing();