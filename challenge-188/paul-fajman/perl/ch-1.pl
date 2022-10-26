#!/usr/bin/perl

# Weekly Challenge 188 Task #1
# You are given list of integers @list of size $n and divisor $k.
#
# Write a script to find out count of pairs in the given list that satisfies the following rules.
#
# The pair (i, j) is eligible if and only if
# a) 0 <= i < j < len(list)
# b) list[i] + list[j] is divisible by k
###############################
use strict;
use warnings;

my @sets = ( [4,5,1,6], [1,2,3,4], [1,3,4,5], [5,1,2,3],[7,2,4,5] );
my @divisors = (2,2,3,4,4);
my @list;
my ($count, $i, $j);

foreach(@sets) {
  undef($count);
  @list = @{ $_ } ;
  print "Input: \@list = @list, \$k = $divisors[0]\n";
  for ($i=0;$i<$#list+1;$i++) {
    for ($j=$i+1;$j<$#list+1;$j++) {
      $count++ if ($list[$i] + $list[$j]) % $divisors[0] eq 0;
    }
  }
  shift(@divisors);
  print "Output: $count\n\n";
}
