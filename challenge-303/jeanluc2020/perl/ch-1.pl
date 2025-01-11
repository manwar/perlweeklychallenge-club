#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-303/#TASK1
#
# Task 1: 3-digits Even
# =====================
#
# You are given a list (3 or more) of positive integers, @ints.
#
# Write a script to return all even 3-digits integers that can be formed using
# the integers in the given list.
#
## Example 1
##
## Input: @ints = (2, 1, 3, 0)
## Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)
#
## Example 2
##
## Input: @ints = (2, 2, 8, 8, 2)
## Output: (222, 228, 282, 288, 822, 828, 882)
#
############################################################
##
## discussion
##
############################################################
#
# First, we create all subsets of @ints containing 3 elements
# Then, we create all possible permutations of those 3 element lists
# and turn those into 3-digit numbers. If that number doesn't start
# in 0 and is even, we keep it for the result (eliminating duplicates
# along the way by storing them as keys in a hash). In the end,
# we can use those as the output.

use strict;
use warnings;
use Data::PowerSet qw(powerset);
use Algorithm::Combinatorics qw(permutations);
use Data::Dumper;

three_digist_even(2, 1, 3, 0);
three_digist_even(2, 2, 8, 8, 2);

sub three_digist_even {
   my @ints = @_;
   print "Input: (" . join(", ", @ints) . ")\n";
   my $result = {};
   my $powerset = powerset( { min => 3, max => 3 }, @ints );
   foreach my $p (@$powerset) {
      my @all_permutations = permutations($p);
      foreach my $perm (@all_permutations) {
         my $num = join("", @$perm);
         next if $num =~ m/^0/;
         $result->{$num} = 1 unless $num % 2;
      }
   }
   print "Output: (" . join(", ", sort {$a<=>$b} keys %$result) . ")\n";
}
