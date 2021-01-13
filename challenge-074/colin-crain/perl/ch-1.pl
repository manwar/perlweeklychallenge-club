#! /opt/local/bin/perl
#
#       majority_ruler.pl
#
#       TASK #1 › Majority Element
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers of size $N.
# 
#         Write a script to find the majority element. If none found then print -1.
# 
#         Majority element in the list is the one that appears more than floor(size_of_list/2).
# 
#         Example 1
#             Input: @A = (1, 2, 2, 3, 2, 4, 2)
#             Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).
# 
#         Example 2
#             Input: @A = (1, 3, 1, 2, 4, 5)
#             Output: -1 as none of the elements appears more than floor(6/2).
# 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @A = @ARGV;
@A = (1, 2, 2, 3, 3, 4, 2, 2, 2) if scalar @A == 0;
say "input: @A";

my %count;
$count{$_}++ for @A;

# version 1:
# is first elem count larger than half list size?
my $max = ( sort { $count{$b} <=> $count{$a} } keys %count )[0];
say "ver 1: ", $count{$max} > int(@A/2) ? $max : -1;

## version 2:
## if first elem same at far side of center?
my @sorted = sort {$count{$b} <=> $count{$a}} @A;
say "ver 2: ", $sorted[0] eq $sorted[int(@A/2)] ? $sorted[0] : -1;

## version 3:
## is maximum count greater than the sum for all other values?
use List::Util qw(sum);
my ($candidate, $count) = ($sorted[0], $count{$sorted[0]});
delete $count{$sorted[0]};
my $others = sum values %count;
say "ver 3: ", $count > $others ? $candidate : -1;