#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/#TASK1
#
# Task 1: Secret Santa
# ====================
#
# Task 1: Secret Santa
# Submitted by: Andreas Voegele
#
# Secret Santa is a Christmas tradition in which members of a group are
# randomly assigned a person to whom they give a gift.
#
# You are given a list of names. Write a script that tries to team persons from
# different families.
#
## Example 1
##
## The givers are randomly chosen but don't share family names with the receivers.
##
## Input: @names = ('Mr. Wall',
##                  'Mrs. Wall',
##                  'Mr. Anwar',
##                  'Mrs. Anwar',
##                  'Mr. Conway',
##                  'Mr. Cross',
##                  );
##
## Output:
##
##     Mr. Conway -> Mr. Wall
##     Mr. Anwar -> Mrs. Wall
##     Mrs. Wall -> Mr. Anwar
##     Mr. Cross -> Mrs. Anwar
##     Mr. Wall -> Mr. Conway
##     Mrs. Anwar -> Mr. Cross
#
## Example 2
##
## One gift is given to a family member.
##
## Input: @names = ('Mr. Wall',
##                  'Mrs. Wall',
##                  'Mr. Anwar',
##                  );
##
## Output:
##
##     Mr. Anwar -> Mr. Wall
##     Mr. Wall -> Mrs. Wall
##     Mrs. Wall -> Mr. Anwar
#
############################################################
##
## discussion
##
############################################################
#
# We create all possible permutations for the input. Then we
# eliminate all of those that have two people of the same family
# next to each other. Then we select one of the remaining
# permutations randomly.

use strict;
use warnings;
use Data::Dumper;
use Algorithm::Permute;

secret_santa('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar', 'Mrs. Anwar', 'Mr. Conway', 'Mr. Cross');
secret_santa('Mr. Wall', 'Mrs. Wall', 'Mr. Anwar');

sub secret_santa {
   my @names = @_;
   my @permutations = ();
   my $p_iterator = Algorithm::Permute->new ( \@names );
   my @current_permutation;
   while (my @perm = $p_iterator->next) {
      @current_permutation = @perm;
      if(valid(@perm)) {
         push @permutations, [@perm];
      }
   }
   print Dumper \@permutations;
   unless(@permutations) {
      push @permutations, [ @current_permutation ];
   }
   my $which = int(rand(scalar(@permutations)));
   my $permutation = $permutations[$which];
   my $last = shift @$permutation;
   push @$permutation, $last;
   foreach my $who (@$permutation) {
      print "$last -> $who\n";
      $last = $who;
   }
}

sub valid {
   my @perm = @_;
   my $last = shift @perm;
   push @perm, $last;
   foreach my $name (@perm) {
      my $family_last = $last;
      $family_last =~ s/.* //;
      my $family_this = $name;
      $family_this =~ s/.* //;
      return 0 if $family_last eq $family_this;
      $last = $name;
   }
   return 1;
}
