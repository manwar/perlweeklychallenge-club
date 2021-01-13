#!/usr/bin/perl -w
use strict;
use warnings;
use v5.26;
use Test::More;
use POSIX qw(floor);
# TASK #1 › Majority Element
# Submitted by: Mohammad S Anwar
# You are given an array of integers of size $N.

# Write a script to find the majority element. If none found then print -1.

# Majority element in the list is the one that appears more than floor(size_of_list/2).

# Example 1
# Input: @A = (1, 2, 2, 3, 2, 4, 2)
# Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).

# Example 2
# Input: @A = (1, 3, 1, 2, 4, 5)
# Output: -1 as none of the elements appears more than floor(6/2).

my @A = (1, 2, 2, 3, 2, 4, 2);
my @B = (1, 3, 1, 2, 4, 5);

sub majority_el
{
  my $arr_ref = shift;
  my $o = {};
  map { $o->{$_}++ } @$arr_ref;
  my ($max) = sort { $o->{$b} <=> $o->{$a} } keys %$o;

  return $o->{$max} >= floor(@$arr_ref/2) ? $max : -1;
}

ok(majority_el(\@A) == 2 );
ok(majority_el(\@B) == -1);

done_testing(2);