#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-199/#TASK1
#
# You are given a list of integers, @list.
#
# Write a script to find the total count of Good Pairs.
#
## A pair (i, j) is called good if list[i] == list[j] and i < j.
#
####################
#
# solution:
#
# The solution to this problem is quite simple. Walk from the first element to
# the last with i, then walk from i to the last element with j, and take a note
# of the pair if list[i] == list[j]. Nothing too wild.

use strict;
use warnings;

# some examples
my @lists = (
   [1,2,3,1,1,3],
   [1,2,3],
   [1,1,1,1],
   [],
   [1,2,3,4,1,2,3,1,2,1]
);

foreach my $list (@lists) {
   find_good_pairs(@$list);
}


sub find_good_pairs {
   my @list = @_;
   my $count = 0;
   foreach my $i (0..$#list) {
      foreach my $j ($i+1..$#list) {
         $count++ if $list[$i] == $list[$j];
      }
   }
   print "[" . join(",",@list) . "] returns $count\n";
}
