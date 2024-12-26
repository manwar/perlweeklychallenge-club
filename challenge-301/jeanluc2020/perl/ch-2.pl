#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-301/#TASK2
#
# Task 2: Hamming Distance
# ========================
#
# You are given an array of integers, @ints.
#
# Write a script to return the sum of Hamming distances between all the pairs
# of the integers in the given array of integers.
#
# The Hamming distance between two integers is the number of places in which
# their binary representations differ.
#
#
## Example 1
##
## Input: @ints = (4, 14, 2)
## Output: 6
##
## Binary representation:
## 4  => 0100
## 14 => 1110
## 2  => 0010
##
## HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 + 2 + 2 = 6.
#
## Example 2
##
## Input: @ints = (4, 14, 4)
## Output: 4
#
############################################################
##
## discussion
##
############################################################
#
# First, we turn each number into its binary representation.
# Then, we check each binary number against each other binary
# number, adding leading zeroes to euqalize the length (by simply
# making all numbers as long as the longest one). Then we
# calculate the Hamming Distance for each pair of numbers and return
# the sum of all of those distances.

use v5.40;

hamming_distance(4, 14, 2);
hamming_distance(4, 14, 4);

sub hamming_distance {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $max_len = 0;
   my @bins = ();
   my $dist = 0;
   foreach my $num (@ints) {
      my $bin = sprintf ("%b", $num);
      my $len = length($bin);
      $max_len = $len if $len > $max_len;
      push @bins, $bin;
   }
   foreach my $i (0..$#bins) {
      my $len = length($bins[$i]);
      my $lendiff = $max_len - $len;
      if($lendiff) {
         $bins[$i] = '0'x$lendiff . $bins[$i];
      }
      foreach my $j ($i+1..$#bins) {
         my $len = length($bins[$j]);
         my $lendiff = $max_len - $len;
         if($lendiff) {
            $bins[$j] = '0'x$lendiff . $bins[$j];
         }
         $dist += _hamming_distance($bins[$i], $bins[$j]);
      }
   }
   print "Output: $dist\n";
}

sub _hamming_distance {
   my ($i, $j) = @_;
   my $dist = 0;
   my @first = split //, $i;
   my @second = split //, $j;
   foreach my $k (0..$#first) {
      $dist++ if $first[$k] != $second[$k];
   }
   return $dist;
}
