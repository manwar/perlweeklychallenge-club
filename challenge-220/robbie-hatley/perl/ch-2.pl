#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-2.pl
Solutions in Perl for The Weekly Challenge 220-2.
Written by Robbie Hatley on Wed Jun 07, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Squareful
Submitted by: Mohammad S Anwar
An array is "squareful" if the sum of every pair of adjacent elements is a perfect square.
Given an array of integers, write a script to find all the permutations of the given array that are squareful.

Example 1:  Input = (1, 17, 8)  Output = ([1, 8, 17], [17, 8, 1])
( 1,  8, 17) since  1 + 8 ==  9 == 3^2 and 8 + 17 == 25 == 5^2.
(17,  8,  1) since 17 + 8 == 25 == 5^2 and 8 +  1 ==  9 == 3^2.

Example 2:  Input = (2, 2, 2)   Output = ([2, 2, 2])
( 2,  2,  2) since  2 + 2 = 4 = 2^2 and 2 + 2 = 4 = 2^2.
( 2,  2,  2) since  2 + 2 = 4 = 2^2 and 2 + 2 = 4 = 2^2.
( 2,  2,  2) since  2 + 2 = 4 = 2^2 and 2 + 2 = 4 = 2^2.
( 2,  2,  2) since  2 + 2 = 4 = 2^2 and 2 + 2 = 4 = 2^2.
( 2,  2,  2) since  2 + 2 = 4 = 2^2 and 2 + 2 = 4 = 2^2.
( 2,  2,  2) since  2 + 2 = 4 = 2^2 and 2 + 2 = 4 = 2^2.
Yes, mathematically, that's correct: There are SIX answers to this example! They look identical on paper
(or on a video screen), but mathematically (combinatorically), the left, middle, and right 2s are distinct.
But since this looks ridiculous visually, I'll relent and erase all visually-duplicate permutations.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
As usual where combinations or permutations are involved, I use CPAN module "Math::Combinatorics" to cut
programming time from one week down to about one hour. And, I use the "uniq" function from "List::Util" to
get rid of any visually-duplicate permutations (see my notes on Example 2 above). And I use five subroutines,
to avoid spaghetti code and repetition, and to keep the main body of the program short.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays in proper Perl syntax, like so:
./ch-2.pl '([13,-4,3],[9,0,16])'

Output is to STDOUT and will be each input array, followed by all squareful permutations.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Math::Combinatorics;
use Math::Prime::Util 'is_power';
use List::Util 'uniq';
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

sub is_int ($x) {
   return $x =~ m/(?:^-[1-9]\d*$)|(?:^0$)|(?:^[1-9]\d*$)/;
}

sub is_array_of_ints ($aref) {
   for my $x (@$aref) {
      return 0 if ! is_int($x);
   }
   return 1;
}

sub is_square ($x) {
   return is_power($x, 2);
}

sub is_squareful_array ($aref) {
   for ( my $i = 1 ; $i <= $#$aref ; ++$i ) {
      return 0 if ! is_square($$aref[$i-1]+$$aref[$i]);
   }
   return 1;
}

sub find_squareful_permutations ($aref) {
   my $combs = Math::Combinatorics->new(count => scalar(@$aref), data => $aref);
   my @sperms;
   while (my @perm = $combs->next_permutation) {
      if (is_squareful_array(\@perm)) {
         push @sperms, sprintf("[@perm]");
      }
   }
   return uniq sort @sperms;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Get execution start time:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [ 1, 17,  8],
   [ 2,  2,  2],
);

# Non-default inputs:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# Loop through arrays:
for my $aref (@arrays) {
   say '';
   # Make sure this is an array of ints:
   if (!is_array_of_ints($aref)) {
      say "Array (@$aref) is not an array of ints; moving on to next array.";
      next;
   }
   # Find all visually-unique squareful permutations of this array:
   my $sref = [find_squareful_permutations($aref)];
   # Print results:
   say "original  array        = (@$aref)";
   say "squareful permutations = (@$sref)";
}

# Determine and print execution time in microseconds:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.3fµs.\n", $µs);
