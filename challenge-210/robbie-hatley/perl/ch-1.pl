#! /bin/perl

########################################################################
# Robbie Hatley's Perl solution to The Weekly Challenge 210-1          #
# Written 2023-03-29 by Robbie Hatley.                                 #
########################################################################

use v5.32;
use strict;
use warnings;
use List::Util 'sum0';

=pod

PROBLEM DESCRIPTION:

Task 1: Kill and Win
Submitted by: Mohammad S Anwar
You are given a list of integers.

Write a script to get the maximum "points" possible from "taking out"
or "killing" (removing) integers from a list. For each integer you 
remove, all integers exactly one-less or one-more will also be removed. 
The "points" will be the total of integers removed. What integers 
should you remove to get maximum points?

Example 1:  Input: (2, 3, 1)           Output: 6
Example 2:  Input: (1, 1, 2, 2, 2, 3)  Output: 11

NOTE RH 2023-03-29: Since one is allowed to remove (or NOT remove)
any integers one wants to, and since the "points" is the sum of 
all integers removed, the "maximum points" will always be the sum
of the positive integers (if any) in the list. One should never 
remove zeros (might reduce score and can't help) or negative integers 
(will always reduce score).

summation of the sequence, or "sum0"
from the "List::Util" module.

INPUT / OUTPUT NOTES:

Input is from built-in array of arrays, or from @ARGV. If using @ARGV,
input should be an array of arrays of integers in proper Perl syntax,
surrounded by 'single quotes', like so:
./ch-1.pl '([-7,-1,0,12,-13],[-4,0,8,7,14])'

Output will be to STDOUT and will be "maximum points".

=cut

# DEFAULT INPUTS:
my @arrays = 
(
   [2,3,1],
   [1,1,2,2,2,3],
   [-7,-1,0,12,-13],
   [-4,0,8,1,7,14]
);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0])}

# MAIN BODY OF SCRIPT:
say '';
say 'Let the integer killings begin.';
for (@arrays){

   # Announce original integer list:
   say '';
   say "Integer list: (@{$_})";

   # Remove all positive integers from list, but take note if we remove 
   # any 1s:
   my @removed = ();
   my $one = 0;
   for ( my $i = 0 ; $i < scalar(@{$_}) ; ++$i ){
      if ( $_->[$i] > 0 ){
         if ( $_->[$i] == 1 ){$one = 1;}
         push @removed, splice @{$_}, $i, 1;
         --$i;
      }
   }

   # If we DID remove any 1s, also remove all zeros, because of the
   # "manually removing any number x automatically removes all x-1 
   # and x+1" rule:
   if ( $one ){
      for ( my $i = 0 ; $i < scalar(@{$_}) ; ++$i ){
         if ( $_->[$i] == 0 ){
            push @removed, splice @{$_}, $i, 1;
            --$i;
         }
      }
   }

   # Announce numbers removed and remnants of original array:
   say "Removed:      (@removed)";
   say "Remaining:    (@{$_})";

   # Calculate and announce final score:
   say "Max points:   ", sum0(@removed);
}
