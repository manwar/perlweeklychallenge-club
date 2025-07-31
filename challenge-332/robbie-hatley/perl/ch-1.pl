#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 332-1,
written by Robbie Hatley on Mon Jul 28, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 332-1: Binary Date
Submitted by: Mohammad Sajid Anwar
You are given a date in the format YYYY-MM-DD.
Write a script to convert it into binary date.

Example #1:
Input: $date = "2025-07-26"
Output: "11111101001-111-11010"

Example #2:
Input: $date = "2000-02-02"
Output: "11111010000-10-10"

Example #3:
Input: $date = "2024-12-31"
Output: "11111101000-1100-11111"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this, I'll make two subroutines: "dec2bin" which converts positive integers expressed as strings of
decimal digits into strings of binary digits, and "date2bin" which changes all clusters of digits in a string
to their binary equivalents by calling "dec2bin" in "s/(\d+)/dec2bin($1)/egr".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted date strings, in proper Perl syntax, like so:

./ch-1.pl '("837-11-19", "2026-9-28")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Convert decimal numbers to binary:
   sub dec2bin ($dec) {sprintf("%b", 0+$dec)}

   # Convert decimal substrings to binary:
   sub date2bin ($date) {$date =~ s/(\d+)/dec2bin($1)/egr}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @dates = @ARGV ? eval($ARGV[0]) : ("2025-07-26",            "2000-02-02",        "2024-12-31"            );
#                 Expected outputs : ("11111101001-111-11010", "11111010000-10-10", "11111101000-1100-11111")

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $date (@dates) {
   say '';
   say "Decimal date = $date";
   my $bd = date2bin($date);
   say "Binary  date = $bd";
}
