#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
ch-2.pl
Solutions in Perl for The Weekly Challenge 217-2.
Written by Robbie Hatley on Wed May 17, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 2: Max Number
Submitted by: Mohammad S Anwar
You are given a list of positive integers. Write a script to concatenate the integers to form the highest
possible value.

Example 1:
Input: @list = (1, 23)
Output: 231

Example 2:
Input: @list = (10, 3, 2)
Output: 3210

Example 3:
Input: @list = (31, 2, 4, 10)
Output: 431210

Example 4:
Input: @list = (5, 11, 4, 1, 2)
Output: 542111

Example 5:
Input: @list = (1, 10)
Output: 110


--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use the "permutations" feature of CPAN module "Math::Combinatorics", rather than try to create a
special "sort" of the numbers for "max value on concatenation". Less-efficient, but MUCH less headachey.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of positive integers in proper Perl syntax, like so:
./ch-2.pl '([13,7,96,8,3,11], [2,6,83,17,7], [478,113,73,14])'

Output is to STDOUT and will be each input array, followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
use Math::Combinatorics;
use List::Util 'max';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:
sub concatenate ($aref) {
   local $"='';
   return 0+"@$aref";
}

sub maxcat ($aref) {
   my $combs = Math::Combinatorics->new(count => scalar(@$aref), data => $aref);
   my @cats;
   while ( my @perm = $combs->next_permutation ) {
      push @cats, concatenate(\@perm);
   }
   return max @cats;
}

# ------------------------------------------------------------------------------------------------------------
# DEFAULT INPUTS:
my @arrays =
(
   [1, 23],
   [10, 3, 2],
   [31, 2, 4, 10],
   [5, 11, 4, 1, 2],
   [1, 10],
);

# ------------------------------------------------------------------------------------------------------------
# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
{ # begin main
   my $t0 = time;
   for my $aref (@arrays) {
      my $maxcat = maxcat($aref);
      say '';
      say "array  = (@$aref)";
      say "maxcat = $maxcat";
   }
   my $µs = 1000000 * (time - $t0);
   printf("\nExecution time was %.3fµs.\n", $µs);
   exit 0;
} # end main
