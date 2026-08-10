#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 384-2,
written by Robbie Hatley on Sat Aug 01, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 384-2: Special Binary Substrings
Submitted by: Mohammad Sajid Anwar
You are given a binary string. Write a script to return all
non-empty substrings (distinct) that have the same number of
0’s and 1’s, and all the 0’s and all the 1’s in these substrings
are grouped consecutively.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I'll use a pair of nested 3-part "for" loops to examine every even-length substring of each input string,
and return only the unique "Special Binary Substrings" as described in the problem description.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either default arguments or via @ARGV. If using @ARGV, provide one-or-more arguments which must
be space-separated single-quoted binary numbers.

Example using @ARGV:
./ch-2.pl '0100101000111011001010' '10101110001101010010100'

Example using default arguments:
./ch-2.pl

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use List::Util 'uniq';
   $"=', ';

   # Find "Special Binary Substrings":
   sub sbs ( $s ) {
      my $n = length($s);
      my @output;
      for    ( my $i = 0 ;    $i   <= $n-2 ; $i += 1 ) {
         for ( my $j = 2 ; $i + $j <= $n-0 ; $j += 2 ) {
            my $ss = substr $s, $i, $j;
            push @output, $ss if '0'x($j/2).'1'x($j/2) eq $ss;
            push @output, $ss if '1'x($j/2).'0'x($j/2) eq $ss;
         }
      }
      return uniq @output;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @bns = @ARGV ? @ARGV :
(
   # Example #1 input:
   '0101',
   # Expected output:  (01, 10)

   # Example #2 input:
   '000111',
   # Expected output:  (000111, 0011, 01)

   # Example #3 input:
   '000011',
   # Expected output:  (0011, 01)

   # Example #4 input:
   '10011100',
   # Expected output:  (10, 0011, 01, 1100)

   # Example #5 input:
   '00000',
   # Expected output:  ()
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $bn (@bns) {
   say '';
   say "Binary number = $bn";
   my @ss = sbs($bn);
   say "Special Binary Substrings = (@ss)";
}
