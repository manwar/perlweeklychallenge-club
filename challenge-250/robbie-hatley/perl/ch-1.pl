#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 250-1.
Written by Robbie Hatley on Sun Dec 31, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 250-1: Smallest Index
Submitted by: Mohammad S Anwar
Given an array of integers @ints, write a script to find the
smallest index i such that i mod 10 == $ints[i]; otherwise,
return -1.

Example 1:
Input: @ints = (0, 1, 2)
Output: 0
i=0: 0 mod 10 = 0 == $ints[0].
i=1: 1 mod 10 = 1 == $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
All indices have i mod 10 == $ints[i], so we return
the smallest index, 0.

Example 2:
Input: @ints = (4, 3, 2, 1)
Output: 2
i=0: 0 mod 10 = 0 != $ints[0].
i=1: 1 mod 10 = 1 != $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
i=3: 3 mod 10 = 3 != $ints[3].
2 is the only index which has i mod 10 == $ints[i].

Example 3:
Input: @ints = (1, 2, 3, 4, 5, 6, 7, 8, 9, 0)
Output: -1
No index satisfies i mod 10 == $ints[i].

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll use a 3-part loop on array index variable $i, starting from 0 and working upward,
and report the first (and hence least) index found for which $i%10 == $ints[$i]

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([-17,4,52,6,8,7,63,8,7,11,5,6,32],[-8,42,75,-36,14,6,5,137,-243,8,77,64,2,3,4])'

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
# GLOBAL VARIABLES:
our $t0    ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 1; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Does a string represent an integer?
sub is_int ($x) {
   $x =~ m/(?:^0$)|(?:^-?[1-9][0-9]*$)/ and return 1 or return 0;
}

# Is @$aref an array of ints?
sub is_array_of_ints ($aref) {
   'ARRAY' ne ref($aref)        and return 0;
   0 == scalar(@$aref)          and return 0;
   for my $element ( @$aref ) {
      !is_int($element)         and return 0;
   }
   return 1;
}

# Return the smallest index $i of @$aref which $i%10==$$aref[$i],
# or return -1 if there is no such index:
sub smallest_index ($aref) {
   for (my $i = 0 ; $i <= $#$aref ; ++$i) {
      $i%10==$$aref[$i] and return $i
   }
   return -1;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   [0, 1, 2],
   # Expected Output: 0

   # Example 2 Input:
   [4, 3, 2, 1],
   # Expected Output: 2

   # Example 3 Input:
   [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
   # Expected Output: -1
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Array = ('.join(', ', @$aref),')';
   !is_array_of_ints($aref) and say 'Error: not an array of integers.'
                            and say 'Skipping to next array.'
                            and next;
   say 'Smallest i for which i%10 == Array[i]: ', smallest_index($aref);
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
