#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a sorted array of distinct integers @N and a target $N. Write a script to return the index of the given target if found otherwise place the target in the sorted array and return the index.
Example 1:

Input: @N = (1, 2, 3, 4) and $N = 3
Output: 2 since the target 3 is in the array at the index 2.

Example 2:

Input: @N = (1, 3, 5, 7) and $N = 6
Output: 3 since the target 6 is missing and should be placed at the index 3.

Example 3:

Input: @N = (12, 14, 16, 18) and $N = 10
Output: 0 since the target 10 is missing and should be placed at the index 0.

Example 4:

Input: @N = (11, 13, 15, 17) and $N = 19
Output: 4 since the target 19 is missing and should be placed at the index 4.

=cut

use List::Util qw(first);

# Actually we have to return index only, thus:

sub return_idx
{
     my ($aref, $num) = @_;
     my %idx;
     @idx{@$aref} = keys @$aref;
     return $idx{$num} if exists $idx{$num};


     my $neighbour = first { $_ > $num } @$aref;
     my $should_be_placed = $neighbour ? $idx{$neighbour} : scalar @$aref;
     return $should_be_placed;
}

print return_idx([1, 2, 3, 4], 3), $/; # 2
print return_idx([1, 3, 5, 7], 6), $/; # 3


print return_idx([12, 14, 16, 18], 10), $/; # 0
print return_idx([11, 13, 15, 17], 19), $/, $/; # 4

# If we do have to modify the array:

sub search_insert
{
     my ($aref, $num) = @_;

     my %idx;
     @idx{@$aref} = keys @$aref;
     return $idx{$num} if exists $idx{$num};
     @$aref = sort {$a <=> $b} @$aref, $num;
     @idx{@$aref} = keys @$aref;
     return $idx{$num};
}


print search_insert([1, 2, 3, 4], 3), $/; # 2
print search_insert([1, 3, 5, 7], 6), $/; # 3

print search_insert([12, 14, 16, 18], 10), $/; # 0
print search_insert([11, 13, 15, 17], 19), $/; # 4