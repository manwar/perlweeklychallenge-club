#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 366-1.
Written by Robbie Hatley.
Edit history:
   Mon Mar 23, 2026: Wrote it.
   Tue Mar 24, 2026: Edited it.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 366-1: Count Prefixes
Submitted by: Mohammad Sajid Anwar
You are given an array of words and a string (contains only
lowercase English letters). Write a script to return the number
of words in the given array that are a prefix of the given string.

(
   # Example #1 input:
   [["a", "ap", "app", "apple", "banana"], "apple"],
   # Expected output: 4

   # Example #2 input:
   [["cat", "dog", "fish"], "bird"],
   # Expected output: 0

   # Example #3 input:
   [["hello", "he", "hell", "heaven", "he"], "hello"],
   # Expected output: 4

   # Example 4 input:
   [["", "code", "coding", "cod"], "coding"],
   # Expected output: 3

   # Example #5 input:
   [["p", "pr", "pro", "prog", "progr", "progra", "program"], "program"],
   # Expected output: 7
);

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

My first approach was this: Given array-of-candidate-words "@array" and string "$string", I incremented a
zero-initialized counter "$pcount" for each "$candidate" within "@array" for which $string =~ m/^$candidate/.
I then returned that counter.

But while that does work, I realized there is a better approach: use "grep" in scalar context to count number
of candidates "$candidate" within "@array" which match "/^$candidate/".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array containing an array of double-quoted words followed by
a single double-quoted word, in proper Perl syntax, like so:

./ch-1.pl '([["rat", "bat", "cat", "rata"],"ratatouille"], [["spat", "spar", "spark"], "sparkplug"])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Count those words in an array of words
   # which are prefixes of a given word:
   sub count_prefixes( $喜 ){
      grep{$喜->[1]=~/^$_/}@{$喜->[0]}
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ᙡ = @ARGV ? eval($ARGV[0]) :
(
   # Example #1 input:
   [["a", "ap", "app", "apple", "banana"], "apple"],
   # Expected output: 4

   # Example #2 input:
   [["cat", "dog", "fish"], "bird"],
   # Expected output: 0

   # Example #3 input:
   [["hello", "he", "hell", "heaven", "he"], "hello"],
   # Expected output: 4

   # Example 4 input:
   [["", "code", "coding", "cod"], "coding"],
   # Expected output: 3

   # Example #5 input:
   [["p", "pr", "pro", "prog", "progr", "progra", "program"], "program"],
   # Expected output: 7
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $ᔳ (@ᙡ) {
   say '';
   say "Reference word = \"$ᔳ->[1]\".";
   say "Array of words = (@{$ᔳ->[0]}).";
   my $pcount = count_prefixes($ᔳ);
   say "Number of prefixes = $pcount.";
}
