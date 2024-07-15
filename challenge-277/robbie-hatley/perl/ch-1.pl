#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 277-1,
written by Robbie Hatley on Thu Jul 11, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 277-1: Count Common
Submitted by: Mohammad Sajid Anwar
Given two arrays of strings,write a script to return the count
of words which appear once-each in the two arrays.

   # Example 1 input:
   [
      ["Perl", "is", "my", "friend"],
      ["Perl", "and", "Raku", "are", "friend"],
   ],
   # Expected output: 2
   # (The words "Perl" and "friend" appear once in each array.)

   # Example 2 input:
   [
      ["Perl", "and", "Python", "are", "very", "similar"],
      ["Python", "is", "top", "in", "guest", "languages"],
   ],
   # Expected output: 1
   # (The word "Python" appears once in each array.)

   # Example 3 input:
   [
      ["Perl", "is", "imperative", "Lisp", "is", "functional"],
      ["Crystal", "is", "similar", "to", "Ruby"],
   ],
   # Expected output: 0
   # ("is" appears twice in the first array so it doesn't count.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
I attack this problem by making a hash keyed by words with each value being a 2-element array containing
counts of how many times that word appears in each array. Then I just count how many keys have both elements
of the value equal to 1 (which means the word appears one-each in the two arrays of words).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of 2 arrays of double-quoted strings, in proper Perl syntax, like so:
./ch-1.pl '([["dog", "pig", "cow"],["bat","cat","pig"]],[["rock","stick","dish"],["metal","grunge","rock"]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.38;
   use utf8;
   no warnings 'uninitialized';
   sub format_array :prototype(\@) ($a) {'('.join(', ', map {"\"$_\""} @$a).')'}
   sub once_each :prototype(\@\@) ($a1, $a2) {
      my %counts;
      ++$counts{$_}->[0] for @$a1;
      ++$counts{$_}->[1] for @$a2;
      my @words = ();
      for my $word (keys %counts) {
         if (1 == $counts{$word}->[0] && 1 == $counts{$word}->[1]) {
            push @words, $word;
         }
      }
      return @words;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   # Example 1 input:
   [
      ["Perl", "is", "my", "friend"],
      ["Perl", "and", "Raku", "are", "friend"],
   ],
   # Expected output: 2
   # (The words "Perl" and "friend" appear once in each array.)

   # Example 2 input:
   [
      ["Perl", "and", "Python", "are", "very", "similar"],
      ["Python", "is", "top", "in", "guest", "languages"],
   ],
   # Expected output: 1
   # (The word "Python" appears once in each array.)

   # Example 3 input:
   [
      ["Perl", "is", "imperative", "Lisp", "is", "functional"],
      ["Crystal", "is", "similar", "to", "Ruby"],
   ],
   # Expected output: 0
   # ("is" appears twice in the first array so it doesn't count.)
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $aref (@arrays) {
   say '';
   my @array1 = @{$aref->[0]};
   my @array2 = @{$aref->[1]};
   my @once  = once_each(@array1, @array2);
   my $count = scalar(@once);
   say 'Array1 = ' . format_array(@array1);
   say 'Array2 = ' . format_array(@array2);
   say "$count words appear once-each in the two arrays: " . format_array(@once);
}
