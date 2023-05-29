#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-1.pl
Solutions in Perl for The Weekly Challenge 218-1.
Written by Robbie Hatley on Thu May 25, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Maximum Product
Submitted by: Mohammad S Anwar
Given a list of 3 or more integers, write a script to find the 3 integers whose product is maximum
and return their product.
Example 1:  Input: (3, 1, 2)              Output:   6
Example 2:  Input: (4, 1, 3, 2)           Output:  24
Example 3:  Input: (-1, 0, 1, 3, 1)       Output:   3
Example 4:  Input: (-8, 2, -9, 0, -4, 3)  Output: 216

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use CPAN module "Math::Combinatorics" again. (It seems I use that a lot these days, as combinations and
permutations keep popping up in TWC and elsewhere.) I'll just make all C(n,3) combinations and return the
triplet with the maximum product and the product.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays in proper Perl syntax, with each inner array being a sequence of integers
(negative, zero, or positive), like so:
./ch-1.pl '([0, -7, 4, 17, 8, 6, 13], [-3, 4, -5, 6, -7, 8], [3, -8, 4, -7, 9, -2, 5, -6])'

Output is to STDOUT and will be the original sequence, followed by the 3-combination with max product,
followed by the max product.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use List::Util  'product';
use List::Util  'max';
use Math::Combinatorics;
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# DEFAULT INPUTS:
my @arrays =
(
   [3, 1, 2],
   [4, 1, 3, 2],
   [-1, 0, 1, 3, 1],
   [-8, 2, -9, 0, -4, 3]
);

# ------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
{ # begin main
   my $t0 = time;
   ARRAY: for my $aref (@arrays) {
      if (scalar(@$aref)<3) {
         say "Array has fewer than 3 elements; skipping to next array.";
         next ARRAY;
      }
      for my $element (@$aref) {
         if ($element !~ m/^(?:-[1-9][0-9]*)|(?:0)|(?:[1-9][0-9]*)$/) {
            say "Array contains non-integer elements; skipping to next array.";
            next ARRAY;
         }
      }
      my @combs = ();
      my $max = product @$aref[0..2];
      my $object = Math::Combinatorics->new(count => 3, data => $aref);
      while(my @comb = $object->next_combination){
         my $product = product @comb;
         if ($product > $max) {$max = $product;}
         push @combs, [[@comb],$product]
      }
      my @sorted = sort {$$b[1]<=>$$a[1]} @combs;
      say '';
      say "Array      = (@$aref)";
      for my $cref (@sorted) {
         last if $$cref[1] != $max;
         say "Max 3-comb = (@{$$cref[0]}); product = $$cref[1]";
      }
   }
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.3fµs.\n", $µs);
   exit 0;
} # end main
