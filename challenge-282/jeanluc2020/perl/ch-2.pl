#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/#TASK2
#
# Task 2: Changing Keys
# =====================
#
# You are given an alphabetic string, $str, as typed by user.
#
# Write a script to find the number of times user had to change the key to type
# the given string. Changing key is defined as using a key different from the
# last used key. The shift and caps lock keys won’t be counted.
#
## Example 1
##
## Input: $str = 'pPeERrLl'
## Ouput: 3
##
## p -> P : 0 key change
## P -> e : 1 key change
## e -> E : 0 key change
## E -> R : 1 key change
## R -> r : 0 key change
## r -> L : 1 key change
## L -> l : 0 key change
#
## Example 2
##
## Input: $str = 'rRr'
## Ouput: 0
#
## Example 3
##
## Input: $str = 'GoO'
## Ouput: 1
#
############################################################
##
## discussion
##
############################################################
#
# We lowercase the whole string first. Then we just need to count
# the number of changes that happen.

use strict;
use warnings;

changing_keys('pPeERrLl');
changing_keys('rRr');
changing_keys('GoO');

sub changing_keys {
   my $str = shift;
   print "Input: '$str'\n";
   $str = lc($str);
   my $last = undef;
   my $changes = 0;
   foreach my $char (split //, $str) {
      if(defined($last)) {
         if($last ne $char) {
            $changes++;
            $last = $char;
         }
      } else {
         $last = $char;
      }
   }
   print "Output: $changes\n";
}
