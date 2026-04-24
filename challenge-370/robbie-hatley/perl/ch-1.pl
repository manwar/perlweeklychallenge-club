#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 370-1,
written by Robbie Hatley on Mon Apr 20, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 370-1: Popular Word
Submitted by: Mohammad Sajid Anwar
You are given a string paragraph and an array of banned words.
Write a script to return the most popular word that is not
banned. It is guaranteed there is at least one word that is not
banned and the answer is unique. The words in paragraph are
case-insensitive and the answer should be in lowercase. The words
cannot contain punctuation symbols.

Example #1:
Inputs:
   [
      "Bob hit a ball, the hit BALL flew far after it was hit.",
      ["hit"],
   ],
Output: "ball"
After removing punctuation and converting to lowercase, the word
"hit" appears 3 times, and "ball" appears 2 times. Since "hit" is
on the banned list, we ignore it.

Example #2:
Inputs:
   [
      "Apple? apple! Apple, pear, orange, pear, apple, orange.",
      ["apple", "pear"],
   ],
Output: "orange"
"apple"  appears 4 times.
"pear"   appears 2 times.
"orange" appears 2 times.
"apple" and "pear" are both banned.
Even though "orange" has the same frequency as "pear", it is the
only non-banned word with the highest frequency.

Example #3:
Inputs:
   [
      "A. a, a! A. B. b. b.",
      ["b"],
   ],
Output: "a"
"a" appears 4 times.
"b" appears 3 times.
The input has mixed casing and heavy punctuation.
The normalised, "a" is the clear winner, since "b" is banned, "a"
is the only choice.

Example #4:
Inputs:
   [
      "Ball.ball,ball:apple!apple.banana",
      ["ball"],
   ],
Output: "apple"
Here the punctuation acts as a delimiter.
"ball"   appears 3 times.
"apple"  appears 2 times.
"banana" appears 1 time.

Example #5:
Inputs:
   [
      "The dog chased the cat, but the dog was faster than the cat.",
      ["the", "dog"],
   ],
Output: "cat"
"the" appears 4 times.
"dog" appears 2 times.
"cat" appears 2 times.
"chased", "but", "was", "faster", "than" appear 1 time each.
"the" is the most frequent but is banned.
"dog" is the next most frequent but is also banned.
The next most frequent non-banned word is "cat".

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The problem description asserts that 3 guarantees exist:

1. That at least one non-banned word exists in the paragraph.
2. That exactly one answer exists.
3. That the words cannot contain punctuation symbols.

But since the problem description fails to specify how those guarantees are to be enforced, I will ignore them
and simply return a list of most-popular non-banned words. That list may be of size 0, 1, or more-than-1. The
words may or may-not contain "punctuation symbols" (eg, "most-popular", "chuột"). To determine popularity,
I'll use a hash of counts of case-folds of all non-banned words found. To provide case-insensitivity, I'll
apply "fc" both to paragraph words and to banned words before each comparison.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array consisting of a double-quoted paragraph followed by
an array of double-quoted single words, in proper Perl syntax, like so:

./ch-1.pl '(["She smiled and she smiled!", ["SmIlEd"]], ["Chuột ăn và ăn mãi rồi chuột chết.", ["ăn"]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use List::Util 'none';

   # Return most-popular non-banned word:
   sub most_popular ( $p , @b ) {
      # Get case-folded list of paragraph words:
      my @pw = map {fc} split /[^\pL\pM\p{Pc}\p{Pd}]+/, $p;
      # Get case-folded list of banned words:
      my @bw = map {fc} @b;
      # Make hash of popularities of non-banned words:
      my %h;
      for my $pword ( @pw ) {
         ++$h{$pword} if none {$pword eq $_} @bw}
      # Make output array of most-popular non-banned words:
      my @out;
      my @keys = reverse sort {$h{$a} <=> $h{$b}} keys %h;
      my $max = 0; @keys and $max = $h{$keys[0]};
      for my $key ( @keys ) {
         last if $max != $h{$key};
         push @out, $key}
      return @out}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 inputs:
   [
      "Bob hit a ball, the hit BALL flew far after it was hit.",
      ["hit"],
   ],
   # Expected output: "ball"

   # Example #2 inputs:
   [
      "Apple? apple! Apple, pear, orange, pear, apple, orange.",
      ["apple", "pear"],
   ],
   # Expected output: "orange"

   # Example #3 inputs:
   [
      "A. a, a! A. B. b. b.",
      ["b"],
   ],
   # Expected output: "a"

   # Example #4 inputs:
   [
      "Ball.ball,ball:apple!apple.banana",
      ["ball"],
   ],
   # Expected output: "apple"

   # Example #5 inputs:
   [
      "The dog chased the cat, but the dog was faster than the cat.",
      ["the", "dog"],
   ],
   # Expected output: "cat"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $p = $aref->[0];
   my @b = @{$aref->[1]};
   my @m = most_popular($p, @b);
   my @qb = map {"\"$_\""} @b;
   my @qm = map {"\"$_\""} @m;
   say "Paragraph: \"$p\"";
   say "Banned words: (@qb)";
   say "Most-popular non-banned words: (@qm)";
}
