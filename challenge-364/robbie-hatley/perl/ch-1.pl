#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge #364-1,
written by Robbie Hatley on Mon Mar 9, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task #364-1: Decrypt String
Submitted by: Mohammad Sajid Anwar
You are given a string formed by digits and ‘#'. Write a script
to map the given string to English lowercase characters given
the following two rules:
1: Characters 'j' to 'z' are represented by '10#' to '26#'.
2: Characters 'a' to 'i' are represented by '1' to '9'.

Example #1:
Input: $str = "10#11#12"
Output: "jkab"

Example #2:
Input: $str = "1326#"
Output: "acz"

Example #3:
Input: $str = "25#24#123"
Output: "yxabc"

Example #4:
Input: $str = "20#5"
Output: "te"

Example #5:
Input: $str = "1910#26#"
Output: "aijz"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Perl’s "s///" operator, in "evaluate globally" mode ("/eg"), will make easy work of this.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted strings, in proper Perl syntax, like so:

./ch-1.pl '("P518#12#", "She had 19#524#.")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # String Decrypter:
   sub string_decrypter ( $s ) {
      my $d = $s;
      $d =~ s/(\d\d)#/($1>9&&$1<27)?chr(96+$1):'�'/eg;
      $d =~ s/(\d)/chr(96+$1)/eg;
      return $d;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0])
                    : ("10#11#12", "1326#", "25#24#123", "20#5", "1910#26#");
# Expected outputs  :   jkab        acz      yxabc        te      aijz

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   say "Raw string = $s";
   my $d = string_decrypter($s);
   say "Decrypted string = $d";
}
