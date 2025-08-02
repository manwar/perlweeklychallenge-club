#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 272-1.
Written by Robbie Hatley on Mon Jun 03, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 272-1: Defang IP Address
Submitted by: Mohammad Sajid Anwar
You are given a valid IPv4 address. Write a script to return the
defanged version of the given IP address. A "defanged" IP address
replaces every period “.” with “[.]".

Example 1:
Input: $ip = "1.1.1.1"
Output: "1[.]1[.]1[.]1"

Example 2:
Input: $ip = "255.101.1.0"
Output: "255[.]101[.]1[.]0"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The "s" operator will make quick work of this:

   sub defang ($x) {$x =~ s/\./[.]/gr}

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted IP4 strings, in proper Perl syntax, like so:
./ch-1.pl '("3.87.253.6", "8.8.8.8", "2.4.4.2", "192.168.67.84")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   sub defang ($x) {$x =~ s/\./[.]/gr}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   "1.1.1.1",
   # Expected output: "1[.]1[.]1[.]1"

   # Example 2 input:
   "255.101.1.0",
   # Output: "255[.]101[.]1[.]0"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $string (@strings) {
   say '';
   say 'Original: ', $string;
   say 'Defanged: ', defang($string);
}
