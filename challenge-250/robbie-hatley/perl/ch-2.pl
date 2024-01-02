#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
Solutions in Perl for The Weekly Challenge 250-2.
Written by Robbie Hatley on Sun Dec 31, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 250-2: Alphanumeric String Value
Submitted by: Mohammad S Anwar
Given an array of alphanumeric strings, write a script to return
the maximum "alphanumeric string value" in the given array, where
"alphanumeric string value" is defined as:
a) If string contains digits only: The base-10 numeric value.
b) Otherwise: The length of the string.

Example 1:
Input:  ("perl", "2", "000", "python", "r4ku")
Output: 6

Example 2:
Input:  ("001", "1", "000", "0001")
Output: 1

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this, I'll make these subs:
1. "sub is_array_of_alnums ($aref)"
2. "sub alnum_string_value ($x)"
3. "sub max_value ($aref)"
My main loop will first check each array to make sure it's an array of alnums, then feed each array to
sub max_value and report the max value. sub max_value($aref) will work by applying "min" from List::Util
to a map which applies alnum_string_value($_) to each $_ in @$aref.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of double-quoted alphanumeric strings, in proper Perl syntax, like so:
./ch-2.pl '(["shivering","B7A64","7"],["9","00097","7q8b9c"])'

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
use List::Util 'max';

# ------------------------------------------------------------------------------------------------------------
# GLOBAL VARIABLES:
our $t0    ; # Seconds since 00:00:00 on Thu Jan 1, 1970.
our $db = 1; # Debug? Set to 0 for no, 1 for yes.

# ------------------------------------------------------------------------------------------------------------
# START TIMER:
BEGIN {$t0 = time}

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:

# Is a given array ref a ref to a non-empty array containing only alphanumeric strings?
sub is_array_of_alnums ($aref) {
   'ARRAY' ne ref($aref) || 0 == scalar(@$aref) and return 0;
   for (@$aref) {!/^[a-zA-Z0-9]+$/ and return 0}
   return 1;
}

# What is the "alphanumeric string value" of a given scalar?
sub alnum_string_value ($x) {
   $x=~/^[0-9]+$/ and return 0+$x or return length($x);
}

# What is the maximum "alphanumeric string value"
# of the elements of an array of alphanumeric strings?
sub max_alnum_string_value ($aref) {
   return max map {alnum_string_value $_} @$aref;
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Inputs:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 Input:
   ["perl", "2", "000", "python", "r4ku"],
   # Expected Output: 6

   # Example 2 Input:
   ["001", "1", "000", "0001"],
   # Expected Output: 1
);

# Main loop:
for my $aref (@arrays) {
   say '';
   !is_array_of_alnums($aref) and say 'Error: Not an array of alphanumeric strings!'
                              and say 'Moving on to next array.'
                              and next;
   say 'Array = (' . join(', ', @$aref) . ')';
   say 'Maximum alphanumeric string value = ', max_alnum_string_value($aref)
}
exit;

# ------------------------------------------------------------------------------------------------------------
# DETERMINE AND PRINT EXECUTION TIME:
END {my $µs = 1000000 * (time - $t0);printf("\nExecution time was %.0fµs.\n", $µs)}
__END__
