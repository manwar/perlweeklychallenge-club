#! /bin/perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
COLOPHON:
This is a 110-character-wide Unicode UTF-8 Perl-source-code text file with hard Unix line breaks ("\x0A").
¡Hablo Español! Говорю Русский. Björt skjöldur. ॐ नमो भगवते वासुदेवाय. 看的星星，知道你是爱。麦藁雪、富士川町、山梨県。

--------------------------------------------------------------------------------------------------------------
TITLE BLOCK:
File name:    "ch-1.pl"
Description:  Solutions in Perl for The Weekly Challenge 221-1.
Authorship:   Written by Robbie Hatley on Mon Jun 12, 2023.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 1: Good Strings
Submitted by: Mohammad S Anwar
You are given a list of strings "@words" and a string "$chars". A string is "good" if it contains only
characters from "$chars", with each character used once-only per string. Write a script to return the sum
of lengths of all elements of "@words" which are "good".

Example 1:  Input: @strings = ("cat", "bt", "hat", "tree"); $chars = "atach";  Output: 6
The good strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.

Example 2:  Input: @strings = ("hello", "world", "challenge"); $chars = "welldonehopper";  Output: 10
The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The problem description, as originally stated on the Weekly Challenge web site, was this:

You are given a list of @words and a string $chars. A string is good if it can be formed by characters from
$chars, each character can be used only once. Write a script to return the sum of lengths of all good strings
in words.

Unfortunately, that contains these two ambiguities:
1. Does "only used once" apply to: (A) each good string individually? (B) all good strings taken together?
2. Does "strings in words" mean: (1) elements? (2) contiguous substrings? (3) combinations? (4) permutations?
That leaves 8 possible interpretations of this problem (A1, A2, A3, A4, B1, B2, B3, B4).

Fortunately, Example 1 rules out B1, B2, B3, B4, because "cat" and "hat" can both be formed even though
$chars only contains one "t", so the "can be used only once" must apply only to one string at a time.

And Example 2 rules out A2, A3, A4 because the word "hell" is disallowed, so "strings in words" must mean
"elements of the array @words", rather than substrings, combinations, or permutations. Example 2 also
rules out B1, B2, B3, B4 because "hello" and "world" collectively contain 3 copies of "l", whereas $chars
only contains 2.

This dramatically simplifies the solution, as one needs only consider each element of @words and ask
"is it good?". And "goodness" will be true if the element can be "formed" by pasting together letters
spliced from a fresh copy of $chars by using substring(). Then just sum the lengths of all "good" elements.

Case note: Since the problem says "characters", not "letters", I'm assuming that it's case sensitive, as
while "t" and "T" are the same letter, they're not the same character. So, "ran" can be made from
"Charles R. Tanner", but not "tan", as "T" is not the same "character" as "t".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of words, with the last word in each array being the string "$chars" for that
array, in proper Perl syntax, like so:
./ch-1.pl '(["ban", "can", "ran", "tan", "Charles R. Tanner"],["bat", "cat", "rat", "brat"])'

Output is to STDOUT and will be each input "@words" array and "$chars" string, followed by the sum of the
lengths of all elements of @words which can be made by pasting-together letters spliced from a fresh copy
of "$string".

=cut

# ------------------------------------------------------------------------------------------------------------
# PRELIMINARIES:
use v5.36;
use strict;
use warnings;
use utf8;
use Sys::Binmode;
use Time::HiRes 'time';
$"=', ';

# ------------------------------------------------------------------------------------------------------------
# SUBROUTINES:
sub is_good ($word, $chars) { # NOTE: "$word" & "$chars" receive COPIES of arguments; originals remain intact.
   my $wlen = length($word);
   my $clen = length($chars);
   WORD: for ( my $i = 0 ; $i < $wlen ; ++$i ) {
      CHARS: for ( my $j = 0 ; $j < $clen ; ++$j ) {
         if ( substr($word, $i, 1) eq substr($chars, $j, 1) ) { # If current word character is found in $chars,
            substr($chars, $j, 1, '');                          # remove character from $chars,
            next WORD}}                                         # and move on to next word character.
      return 0; # We couldn't find current word character in $chars, hence this word is not "good".
   }
   return 1; # Every character of $word was found in $chars.
}

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Start timer:
my $t0 = time;

# Default inputs:
my @arrays =
(
   [ "cat", "bt", "hat", "tree",     "atach"          ],
   [ "hello", "world", "challenge",  "welldonehopper" ],
);

# Non-default inputs:
if (@ARGV) {@arrays = eval($ARGV[0]);}

# Main loop:
for my $wref (@arrays) {
   say '';
   my @words = @{$wref};
   my $chars = pop @words;
   my $tally = 0;
   for my $word (@words) {
      if ( is_good($word, $chars) ) {
         $tally += length($word);
      }
   }
   say "\@words: (@words)  \$chars: \"$chars\"";
   say "Sum of lengths of \"good\" words: $tally";
}

# Determine and print execution time:
my $µs = 1000000 * (time - $t0);
printf("\nExecution time was %.3fµs.\n", $µs);
