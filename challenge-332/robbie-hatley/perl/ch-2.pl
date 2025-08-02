#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 332-2,
written by Robbie Hatley on Mon Jul 28, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 332-2: Odd Letters
Submitted by: Mohammad Sajid Anwar
You are given a string. Write a script to find out if each
letter in the given string appeared odd number of times.

Example #1:
Input:  "weekly"
Output: false

Example #2:
Input:  "Perl"
Output: true

Example #3:
Input:  "challenge"
Output: false

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use a hash to keep track of the number of times each letter appears, then I'll use the "none" function
from CPAN module "List::Util" to determine if none of the keys of the hash have even values.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-2.pl '("ratification", "undue", "ethanol", "momentum")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'none';

   # Are all letter abundances in a string odd?
   sub odd_letters ($s) {
      my %h;
      for (split //,$s) {
         ++$h{$_} if $_ =~ m/\pL/
      }
      none {0==$h{$_}%2} keys %h;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) : ("weekly", "Perl", "challenge");
#                  Expected outputs :   false     true    false

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   say "String = $string";
   my $true_false = odd_letters($string) ? 'true' : 'false';
   say "Odd letters? $true_false";
}
