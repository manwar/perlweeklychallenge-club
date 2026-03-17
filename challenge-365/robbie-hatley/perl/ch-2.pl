#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 365-2,
written by Robbie Hatley on Mon Mar 16, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 365-2: Valid Token Counter
Submitted by: Mohammad Sajid Anwar
You are given a sentence. Write a script to split the given
sentence into space-separated tokens and count how many are valid
words. A token is valid if it contains no digits, has at most one
hyphen surrounded by lowercase letters, and at most one
punctuation mark (!, ., ,) appearing only at the end.

Example 1 input: $str = "cat and dog"
Expected output: 3

Example 2 input: $str = "a-b c! d,e"
Expected output: 2

Example 3 input: $str = "hello-world! this is fun"
Expected output: 4

Example 4 input: $str = "ab- cd-ef gh- ij!"
Expected output: 2

Example 5 input: $str = "wow! a-b-c nice."
Expected output: 2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I start by fully decomposing any extended grapheme clusters (so that any combining marks become separate
Unicode codepoints); then I strip-out all combining marks (so that lower-case letters can easily be recognized
as such); then I split the sentence on whitespace to tokens; then I scrutinizing all tokens and count only
those which do not disobey the rules; then I return my final count.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of double-quoted sentences, in proper Perl syntax, like so:

./ch-2.pl '("Robbie ran 9 times,, around the track!", "--skew --tiger -- bat", "he sha,ved his face")'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use Unicode::Normalize 'NFD';

   # Count the word-like tokens in a sentence:
   sub cwlt ( $s ) {                                    # "cwlt" = "Count Word-Like Tokens"
      my $d = NFD $s;                                   # Decompose extended grapheme clusters.
      $d =~ s/\pM//g;                                   # Remove all combining marks.
      my @t = split /\s+/, $d;                          # Get array of tokens
      my $valid = 0;                                    # Count valid tokens.
      for (@t) {                                        # Scrutinize tokens.
         next if !m/[[:graph:]]/;                       # Token must contain at least 1 visible character.
         next if  m/[0-9]/;                             # No digits allowed.
         my $hcnt = () = m/-/g;                         # Get count of hyphens.
         next if $hcnt > 1;                             # No more than one hyphen is allowed.
         if (1 == $hcnt) {                              # If one hyphen is present:
            my $hidx = index $_, '-';                   #    Get index of hyphen.
            next if      0       == $hidx;              #    Not allowed to be first character.
            next if length($_)-1 == $hidx;              #    Not allowed to be last  character.
            next if substr($_, $hidx-1, 1) !~ m/[a-z]/; #    Must be preceded by lower-case letter.
            next if substr($_, $hidx+1, 1) !~ m/[a-z]/} #    Must be succeeded by lower-case letter.
         my $pcnt = () = m/[,.!]/gp;                    # Get count of punctuations.
         next if $pcnt > 1;                             # No more than one punctuation is allowed.
         if (1 == $pcnt) {                              # If one punctuation is present:
            my $pidx = index $_, ${^MATCH};             #    Get index of punctuation.
            next if length($_)-1 != $pidx}              #    Not allowed to NOT be last character.
         ++$valid}                                      # Increment count of valid tokens.
      return $valid}                                    # Return result.

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @strings = @ARGV ? eval($ARGV[0]) :
(
   "cat and dog",              # Expected output: 3
   "a-b c! d,e",               # Expected output: 2
   "hello-world! this is fun", # Expected output: 4
   "ab- cd-ef gh- ij!",        # Expected output: 2
   "wow! a-b-c nice.",         # Expected output: 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $string (@strings) {
   say '';
   my $vtc = cwlt($string);
   say "Sentence = \"$string\"";
   say "Count of valid tokens = $vtc";
}
