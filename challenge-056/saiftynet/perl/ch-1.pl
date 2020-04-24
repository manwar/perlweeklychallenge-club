#!/usr/env/perl
# Task 1 Challenge 056 Solution by saiftynet
# Diff-K
# You are given an array @N of positive integers (sorted) and another 
# non negative integer k.
# Write a script to find if there exists 2 indices i and j such 
# that A[i] - A[j] = k and i != j.
# It should print the pairs of indices, if any such pairs exist.
# Example:
#     @N = (2, 7, 9)    $k = 2Output : 2,1


# A rather simpler task than Task 2, most of the function
# definition is in the question

use strict; use warnings;

my @N = (2, 7, 9);  # the tasks expects list to be sorted, handy.
my $k=2;            

diff_k($k,@N);

sub diff_k{
  my ($k,@list)=@_;   # list may be passed as a list or ArrayRef
  @list=@{$list[0]}if (scalar @list==1); 
  for my $i(1..$#list){      # i is any number 1 to end index
      for my $j  (0..$i-1){  # j is smaller than i
        print $i,",",$j,"\n" if ($list[$i]-$list[$j])==$k;
      }
  }
}

