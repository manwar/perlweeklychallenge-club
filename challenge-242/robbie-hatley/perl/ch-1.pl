#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 242-1.
Written by Robbie Hatley on Mon Nov 06, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 1: Missing Members
Submitted by: Mohammad S Anwar
Given two arrays of integers, write a script to find the [unique]
members of each array which are missing in the other array.

Example 1:
Input:  @arr1 = (1, 2, 3); @arr2 = (2, 4, 6);
Output: ([1, 3], [4, 6])
(1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
(2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).

Example 2:
Input:  @arr1 = (1, 2, 3, 3); @arr2 = (1, 1, 2, 2);
Output: ([3], [])
(1, 2, 3, 3) has 2 members (3, 3) missing in the array
(1, 1, 2, 2). Since they are same, keep just one.
(1, 1, 2, 2) has 0 members missing in the array (1, 2, 3, 3).

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

The original problem description didn't specify the word [unique], but Example 2 makes it clear that we are
looking for unique (no repeats) members of each array which are missing in the other. So I'll first make
"unique" versions of each array by using the "uniq" function from List::Util and the built-in "sort" function:
use List::Util 'uniq';
@unique1 = uniq sort @arr1;
@unique2 = uniq sort @arr2;
Then I'll just see which elements of @unique1 aren't in @unique2 and vice-versa. I'll make subs "is_int",
"are_ints", "is_in", and "missing" to do most of the work, then call these from the main array loop:

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of two arrays of integers, in proper Perl syntax, like so:
./ch-1.pl '([[-3,8,42,7,11],[6,47,42,11,9]],[[3,5,7,9],[2,4,6,8]],[[2,3,5,8],[2,3,5,8]])'

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
use List::Util 'uniq';

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
our $t0;
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Is a given scalar a decimal representation of an integer?
sub is_int ($x) {
   return $x =~ m/^-[1-9]\d*$|^0$|^[1-9]\d*$/;
}

# Does a referred-to array contain only decimal representations of integers?
sub are_ints ($aref) {
   for (@$aref){return 0 if !is_int($_)}
   return 1;
}

# Is a given element in a referred-to array?
sub is_in ($x, $aref) {
   for (@$aref){return 1 if $_ == $x}
   return 0;
}

# Return an array of two arrays of elements which are "missing"
# relative to a pair of referred-to arrays:
sub missing ($aref1, $aref2) {
   my @unique1 = uniq sort {$a<=>$b} @$aref1;
   my @unique2 = uniq sort {$a<=>$b} @$aref2;
   my @missing1;
   my @missing2;
   for (@unique1){push @missing1, $_ if !is_in($_, \@unique2)}
   for (@unique2){push @missing2, $_ if !is_in($_, \@unique1)}
   return ([@missing1],[@missing2]);
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   #Example 1 Input:
   [[1, 2, 3],[2, 4, 6]],
   #Expected output: ([1, 3], [4, 6])

   #Example 2 Input:
   [[1, 2, 3, 3],[1, 1, 2, 2]],
   #Expected output: ([3], [])
);

# Main loop:
for my $aref (@arrays) {
   say '';
   say 'Array1 = (' . join(', ', @{$$aref[0]}) . ')';
   say 'Array2 = (' . join(', ', @{$$aref[1]}) . ')';
   if ( !are_ints($$aref[0]) || !are_ints($$aref[1]) ) {
      say 'Error: array pair contains non-integer elements;';
      say 'skipping to next array pair.';
      next;
   }
   my @missing = missing($$aref[0],$$aref[1]);
   say 'Mssng1 = (' . join(', ', @{$missing[0]}) . ')';
   say 'Mssng2 = (' . join(', ', @{$missing[1]}) . ')';
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
