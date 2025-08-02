#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 296-1,
written by Robbie Hatley on Mon Nov 18, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 296-1: String Compression
Submitted by: Mohammad Sajid Anwar
You are given a string of alphabetic characters, $chars. Write a
script to compress the string with run-length encoding, as shown
in the examples. A compressed unit can be either a single
character or a count followed by a character. BONUS: Write a
decompression function.

Example 1:
Input: $chars = "abbc"
Output: "a2bc"

Example 2:
Input: $chars = "aaabccc"
Output: "3ab3c"

Example 3:
Input: $chars = "abcc"
Output: "ab2c"

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Since this problem involves an input consisting of a string of characters processed in left-to-right order,
we need only keep track of the "current character" and begin point of the previous segment, where a "segment"
is a contiguous block of 1-or-more identical characters. Each time we reach the beginning of a new segment
(or the one-past-end index), the length of the previous segment will be index - prev. Then set prev = index
and move to the next character, until all segment lengths (and their characters) have been determined. Each
segment will be written to the compressed string as "length followed by character" (except for segments of
length 1, which will be written as just the character).

I've also included

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more arguments which must
be quoted strings, like so:
./ch-1.pl "She ate three hot dogs." "Oooscaaarrrrr Maaaadiisooonnn"
./ch-1.pl -d "She ate thr2e hot dogs." "O2osc3a5r M4ad2is3o3n"

Output is to STDOUT and will be each input followed by the compressed (or decompressed) output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;
   sub compress ($x) {
      my $n    = length($x);
      my $prev = 0;
      my $slen = 0;
      my $char = substr $x, 0, 1;
      my $compressed = '';
      for my $i (1..$n) {
         # If we've gone one-past-end, or if current character is different from
         # previous, calculate length of previous segment, tack compressed version
         # to end of $compressed, and update $char and $prev (provided $i < $n):
         if ($i == $n || substr($x,$i,1) ne $char) {
            $slen = $i - $prev;
            if (1 == $slen) {$compressed .= $char}
            else {$compressed .= ($slen . $char)}
            if ($i < $n) {
               $char = substr($x,$i,1);
               $prev = $i;
            }
         }
      }
      return $compressed;
   }

   sub decompress ($x) {
      $x =~ s/(\d+)(\D)/${2}x${1}/ger;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my $decode = 0;
if ( scalar(@ARGV) > 1 && ('-d' eq $ARGV[0] || '--decode' eq $ARGV[0]) ) {
   $decode = 1;
   shift @ARGV;
}
my @strings = @ARGV ? @ARGV :
# Example inputs:
(
   "abbc",    # Expected output: a2bc
   "aaabccc", # Expected output: 3ab3c
   "abcc",    # Expected output: ab2c
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   if ($decode) {
      my $decomp = decompress($string);
      say "String       = $string";
      say "Decompressed = $decomp"
   }
   else {
      my $compressed = compress($string);
      say "String     = $string";
      say "Compressed = $compressed";
   }
}
