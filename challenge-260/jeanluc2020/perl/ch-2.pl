#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/#TASK2
#
# Task 2: Dictionary Rank
# =======================
#
# You are given a word, $word.
#
# Write a script to compute the dictionary rank of the given word.
#
## Example 1
##
## Input: $word = 'CAT'
## Output: 3
##
## All possible combinations of the letters:
## CAT, CTA, ATC, TCA, ACT, TAC
##
## Arrange them in alphabetical order:
## ACT, ATC, CAT, CTA, TAC, TCA
##
## CAT is the 3rd in the list.
## Therefore the dictionary rank of CAT is 3.
#
## Example 2
##
## Input: $word = 'GOOGLE'
## Output: 88
#
## Example 3
##
## Input: $word = 'SECRET'
## Output: 255
#
############################################################
##
## discussion
##
############################################################
#
# We first create all possible permutations, for which we use an
# iterator-based solution from Algorithm::Permute. Then we keep
# all permutations, removing duplicates (Algorithm::Permute will
# for example generate the word "GOOGLE" twice, once for each "O"
# in the first and the second of two possible positions). Then we
# just walk the sorted list, counting the index while walking, and
# returning 1+index once we found the original word.

use strict;
use warnings;
use Algorithm::Permute;

dictionary_rank('CAT');
dictionary_rank('GOOGLE');
dictionary_rank('SECRET');

sub dictionary_rank {
   my $word = shift;
   print "Input: '$word'\n";
   my @chars = split //, $word;
   my @permutations = ();
   my $p_iterator = Algorithm::Permute->new ( \@chars );
   my $seen = {};
   while(my @perm = $p_iterator->next) {
      my $w = join("", @perm);
      push @permutations, $w unless $seen->{$w};
      $seen->{$w} = 1;
   }
   my @sorted = sort @permutations;
   print join(", ", @sorted) . "\n";
   my $i = 0;
   while($i <= $#sorted) {
      if($sorted[$i] eq $word) {
         $i++;
         print "Output: $i\n";
         last;
      }
      $i++;
   }
}
