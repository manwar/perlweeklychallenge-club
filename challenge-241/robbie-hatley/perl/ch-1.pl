#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 241-1.
Written by Robbie Hatley on Sun Oct 29, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Arithmetic Triplets
Submitted by: Mohammad S Anwar
Given an array "nums" of 3-or-more integers in increasing order,
and a positive integer "diff", write a script to find the number
of unique "Arithmetic Triplets", where an "Arithmetic Triplet"
is a trio of numbers from nums which satisfies these rules:
a) i < j < k
b) nums[j] - nums[i] == diff
c) nums[k] - nums[j] == diff

Example 1:
Input:  @nums = (0, 1, 4, 6, 7, 10), $diff = 3
Output: 2
Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.
Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.

Example 2:
Input: @nums = (4, 5, 6, 7, 8, 9), $diff = 2
Output: 2
(0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
(1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I could resort to using CPAN module Math::Combinatorics as I usually do any time
a problem involves permutations or combinations, but in this case that seems like overkill to me, so I'll
use triple-nested three-part loops instead. I'll check to make sure all array elements are integers, but I
won't enforce the restriction that they be in increasing order, because there's no need: it wouldn't make my
program malfunction, and subsequences of non-monotonic sequences can still be arithmetic triplets. For
example, (17, -32, 53, -34, 47, -36, 14) contains the arithmetic triplet (-32, -34, -36) with period -2.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
double-quoted array of arrays of integers, apostrophes escaped, in proper Perl syntax, like so:
./ch-1.pl "([17, -32, 53, -34, 47, -36, 14, -2], [1, 17, 20, 28, 30, 39, 42, 11])"

Output is to STDOUT and will be each input array followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS AND MODULES USED:

use v5.38;
use strict;
use warnings;
use utf8;
use warnings FATAL => 'utf8';
use Sys::Binmode;
use Time::HiRes 'time';

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0; BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Format an array of ints as (3, 17, -42, 487):
sub arraystr (@array) {return '(' . join(', ', @array) . ')'}

# Is a given string a decimal representation of an integer?
sub is_int ($x) {return $x =~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/}

# Does a given array contain only three-or-more integers?
sub three_plus_ints (@array) {
   return 0 if scalar(@array) < 3;
   for ( my $i = 0 ; $i <= $#array ; ++$i ) {
      return 0 if !is_int($array[$i]);
   }
   return 1;
}

sub arithmetic_triplets ($aref, $diff) {
   my @triplets;
   for       ( my $i =    0   ; $i <= $#$aref - 2 ; ++ $i ) {
      for    ( my $j = $i + 1 ; $j <= $#$aref - 1 ; ++ $j ) {
         for ( my $k = $j + 1 ; $k <= $#$aref - 0 ; ++ $k ) {
               $$aref[$k]-$$aref[$j] == $diff
            && $$aref[$j]-$$aref[$i] == $diff
            and push @triplets, [@$aref[$i, $j, $k]];
         }
      }
   }
   return @triplets;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 inputs:
   [0, 1, 4, 6, 7, 10, 3],

   # Example 2 inputs:
   [4, 5, 6, 7, 8, 9, 2],
);

# Main loop:
for my $aref (@arrays) {
   say '';
   my @array = @$aref;
   my $diff  = pop @array;
   say 'Array = ', arraystr(@$aref);
   !three_plus_ints(@array)
   and say 'Error: Array may contain only 3-or-more integers; skipping to next array.'
   and next;
   say "Diff = $diff";
   my @triplets = arithmetic_triplets(\@array, $diff);
   my $n = scalar(@triplets);
   !$n and say "Array contains no arithmetic triplets of difference $diff.";
   $n  and say "Array contains $n arithmetic triplets of difference $diff:";
   $n  and say arraystr(@$_) for @triplets;
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
