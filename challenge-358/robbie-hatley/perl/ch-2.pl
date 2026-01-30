#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 358-2,
written by Robbie Hatley on Fri Jan 30, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 358-2: Encrypted String
Submitted by: Mohammad Sajid Anwar
You are given a string $str and an integer $int. Write a script
to encrypt the string using this algorithm: for each character
$char in $str, replace $char with the $int th character after
$char in the alphabet, wrapping if needed and return the
encrypted string.

Example #1:
Input: $str = "abc", $int = 1
Output: "bcd"

Example #2:
Input: $str = "xyz", $int = 2
Output: "zab"

Example #3:
Input: $str = "abc", $int = 27
Output: "bcd"

Example #4:
Input: $str = "hello", $int = 5
Output: "mjqqt"

Example #5:
Input: $str = "perl", $int = 26
Output: "perl"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is a "rotation" variant of a Caesar cipher, akin to "ROT13". I'll use the ASCII codes for "a" and "A" as
"base" ASCII codes. Then for each alphabetic (/[a-zA-Z]/)character to be encoded, I'll use "ord" to get the
ASCII code, calculate the "offset" of each letter relative to one of those bases, add the "$int" value, take
modulo 26, add the result to the base, and feed the result to "chr" to form the encoded character.
(Non-alphabetic characters, I'll send-through verbatim.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array containing a double-quoted string followed by an integer,
in proper Perl syntax, like so:

./ch-2.pl '(["Hatley", -72], ["Hatley", 6], ["Hatley", 11],["Hatley", 17])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Do rotational encoding of string $s by amount $i:
   sub rotate ( $s , $i ) {
      my @inp_chars = split '', $s;
      my @out_chars;
      foreach my $inp_char (@inp_chars) {
         if ($inp_char =~ m/[a-z]/) {
            push @out_chars, chr(97+((ord($inp_char)-97)+$i)%26);
         }
         elsif ($inp_char =~ m/[A-Z]/) {
            push @out_chars, chr(65+((ord($inp_char)-65)+$i)%26);
         }
         else {
            push @out_chars, $inp_char;
         }
      }
      join '', @out_chars;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   ["abc", 1],
   # Expected output: "bcd"

   # Example #2 inputs:
   ["xyz", 2],
   # Expected output: "zab"

   # Example #3 inputs:
   ["abc", 27],
   # Expected output: "bcd"

   # Example #4 inputs:
   ["hello", 5],
   # Expected output: "mjqqt"

   # Example #5 inputs:
   ["perl", 26],
   # Expected output: "perl"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $s = $aref->[0];
   my $i = $aref->[1];
   say "String = \"$s\"";
   my $r = rotate($s, $i);
   say "String rotated by $i = \"$r\"";
}
