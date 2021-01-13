#! /opt/local/bin/perl
#
#       peak_power.pl
#
#       TASK #1 › Peak Element
#         Submitted by: Mohammad S Anwar
#         You are given positive integer $N (>1).
# 
#         Write a script to create an arr of size $N with random unique elements between 1 and 50.
# 
#         In the end it should print peak elements in the arr, if found.
# 
#         An arr element is called peak if it is bigger than it’s neighbour.
# 
#         Example 1
#         Array: [ 18, 45, 38, 25, 10, 7, 21, 6, 28, 48 ]
#         Peak: [ 48, 45, 21 ]
#         Example 2
#         Array: [ 47, 11, 32, 8, 1, 9, 39, 14, 36, 23 ]
#         Peak: [ 47, 32, 39, 36 ]
# 
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $n = shift @ARGV // 10;

die "cannot create more than 50 unique elements" if $n > 50;

## make a list of n unique numbers
## --> encapsulating the arr in 0s  
##     makes the comparisons at the ends easy
my @pool = (1..50);
my @arr = (0);
push @arr, splice( @pool, int(rand(@pool)) , 1 ) while (@arr < $n+1);
push @arr, 0;

say "input array: @arr[1..@arr-2]";

## map over the array indices, grepping the comparison and then 
## converting back into values
my @output = map  { $arr[$_] } 
             grep { ($arr[$_-1] < $arr[$_] && $arr[$_] > $arr[$_+1]) }
             (1..@arr-2);
           
say "peak values: @output";
