#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 372-1,
written by Robbie Hatley on Dow Mon Dm, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 372-1: Rearrange Spaces
Submitted by: Mohammad Sajid Anwar
You are given a string text of words that are placed among a
number of spaces. Write a script to rearrange the spaces so that
there is an equal number of spaces between every pair of adjacent
words and that number is maximised. If you can’t distribute,
place the extra spaces at the end. Finally return the string.

(
   # Example #1 input:
   "  challenge  ",
   # Expected output: "challenge    "

   # Example #2 input:
   "coding  is  fun",
   # Expected output: "coding  is  fun"

   # Example #3 input:
   "a b c  d",
   # Expected output: "a b c d "

   # Example #4 input:
   "  team      pwc  ",
   # Expected output: "team          pwc"

   # Example #5 input:
   "   the  weekly  challenge  ",
   # Expected output: "the    weekly    challenge "
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I'll use this procedure:
1. Count available spaces s.
2. Trim leading and trailing spaces.
3. Split string to @words on spaces.
4. Count gaps between words (n words means n-1 gaps).
5. Form quotient q and remainder r of spaces/gaps.
   (But if 0 == gaps, q=0 and r=s.)
6. return join(@words, ' ' x $q) . (' ' x $r);

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more arguments which must
be space-separated double-quoted sentences, in proper Perl syntax, like so:

./ch-1.pl "  The rat  sat by the   cat." "Over the  fields   she    roamed     and      wandered."

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Distribute the spaces in a sentence $s:
   sub distribute_spaces ( $s ) {
      my @l = ($s =~ m/ /g);         # Get array of spaces.
      my $m = scalar @l;             # Count spaces.
      $s =~ s/^ +//;                 # Trim leading  spaces.
      $s =~ s/ +$//;                 # Trim trailing spaces.
      my @words = split / +/, $s;    # Get words.
      my $n = scalar @words;         # Number of words.
      my ($q, $r);                   # Quotient and remainder.
      if ( $n < 2 ) {                # If fewer than two words,
         $q = 0;                     # quotient is 0 and
         $r = $m}                    # remainder is number of spaces.
      else {                         # Otherwise,
         $q = int $m/($n-1);         # quotient is int(spaces/gaps) and
         $r = $m - ($n-1)*$q}        # remainder is number of leftover spaces.
      return join(' ' x $q, @words)  # Return space-separated words
               . (' ' x $r)}         # followed by remaining spaces.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? @ARGV :
(
   # Example #1 input:
   "  challenge  ",
   # Expected output: "challenge    "

   # Example #2 input:
   "coding  is  fun",
   # Expected output: "coding  is  fun"

   # Example #3 input:
   "a b c  d",
   # Expected output: "a b c d "

   # Example #4 input:
   "  team      pwc  ",
   # Expected output: "team          pwc"

   # Example #5 input:
   "   the  weekly  challenge  ",
   # Expected output: "the    weekly    challenge "
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $s (@strings) {
   say '';
   say "  Original  sentence: \"$s\"";
   my $d = distribute_spaces($s);
   say "Distributed sentence: \"$d\"";
}
