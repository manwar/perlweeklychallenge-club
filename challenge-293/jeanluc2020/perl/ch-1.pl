#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-293/#TASK1
#
# Task 1: Similar Dominos
# =======================
#
# You are given a list of dominos, @dominos.
#
# Write a script to return the number of dominoes that are similar to any other
# domino.
#
### $dominos[i] = [a, b] and $dominos[j] = [c, d] are same if either (a = c and
### b = d) or (a = d and b = c).
#
## Example 1
##
## Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
## Output: 2
##
## Similar Dominos: $dominos[0], $dominos[1]
#
## Example 2
##
## Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
## Output: 3
##
## Similar Dominos: $dominos[0], $dominos[1], $dominos[3]
#
############################################################
##
## discussion
##
############################################################
#
# First, we create a list of sorted dominos (so [3, 1] turns into
# [1, 3]). Then, we count each domino by using the first number as
# the first key and the second number as the second key in a
# nested hash. In the end, we sum up all hash elements with more
# than one occurence.

use strict;
use warnings;

similar_dominos([1, 3], [3, 1], [2, 4], [6, 8]);
similar_dominos([1, 2], [2, 1], [1, 1], [1, 2], [2, 2]);

sub similar_dominos {
   my @dominos = @_;
   my @sorted_dominos = map { [ sort @$_ ] } @dominos;
   print "Input: (" . join(", ", map { "[$_->[0], $_->[1]]" } @dominos ) . ")\n";
   print "Sorted input: (" . join(", ", map { "[$_->[0], $_->[1]]" } @sorted_dominos ) . ")\n";
   my $data;
   foreach my $domino (@sorted_dominos) {
      $data->{$domino->[0]}->{$domino->[1]}++;
   }
   my $count = 0;
   foreach my $i (keys %$data) {
      foreach my $j (keys %{$data->{$i}}) {
         $count += $data->{$i}->{$j} if $data->{$i}->{$j} > 1;
      }
   }
   print "Output: $count\n";
}

