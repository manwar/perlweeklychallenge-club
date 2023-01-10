#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-199/#TASK2
#
# You are given an array of integers, @array and three integers $x,$y,$z.
#
# Write a script to find out total Good Triplets in the given array.
# 
# A triplet array[i], array[j], array[k] is good if it satisfies the following conditions:
# 
## a) 0 <= i < j < k <= n (size of given array)
## b) abs(array[i] - array[j]) <= x
## c) abs(array[j] - array[k]) <= y
## d) abs(array[i] - array[k]) <= z
# 
#####################################
#
# solution:
#
# The solution to this problem is a bit similar to the first one where we have
# to walk the array with 2 variables; now we need three, and the check we have
# to do for each iteration is a bit more complicated.
#


use strict;
use warnings;

# some examples

my @examples = (
   [[3,0,1,1,9,7], 7, 2, 3],
   [[1,1,2,2,3],0,0,1]
);

foreach my $example (@examples) {
   my ($list, $x, $y, $z) = @$example;
   find_good_triplets($x, $y, $z, @$list);
}

sub find_good_triplets {
   my ($x, $y, $z, @list) = @_;
   my $count = 0;
   foreach my $i (0..$#list) {
      foreach my $j ($i+1..$#list) {
         foreach my $k ($j+1..$#list) {
            $count++ if abs($list[$i]-$list[$j]) <= $x and abs($list[$j]-$list[$k]) <= $y and abs($list[$i]-$list[$k]) <= $z;
         }
      }
   }
   print "[" . join(",",@list) . "] returns $count\n";
}

