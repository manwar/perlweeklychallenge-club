#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 390-2,
written by Robbie Hatley on Sun Sep 13, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 390-2: Order Characters
Submitted by: Mohammad Sajid Anwar
You are given a string $s (containing only alphabetic characters)
and an integer $k > 0. Write a script to choose one of the first
$k letters of given string and append it at the end of the
string. You keep doing this until you have lexicographically
smallest string and return the string.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I note that this problem is really two separate problems pasted together:

If $k is 1, then the ONLY strings we can make are the length($s) rotations of $s.

If $k is > 1, then any two adjacent letters can be swapped. If any two adjacent letters can be swapped, then
any letter can be shuffled to any index. If any letter can be shuffled to any index, then all possible
permutations can be created. If all possible permutations can be created, then the lexicographically-smallest
word which can be created is always join(sort(split(word))).

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated single-quoted
arguments, each of which must consist of an alphabetic string, followed by a space, followed by a positive
integer no greater than the length of the string. Example (two invalid inputs followed by two valid inputs):

./ch-2.pl 'd9*j4&# 3' 'skfgrb 5 Greg' 'slgvjaheyf 4' 'slvaHtR 1'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;

   # Aggregate the belchers under the resinous swamps:
   sub order_characters ( $s, $k ) {
      # unless $s is purely-alphabetic, input is invalid:
      unless ( $s =~ m/^[a-zA-Z]+$/ ) {
         return 'Error: Invalid string.';
      }
      # Unless $k is a positive integer, input is invalid:
      unless ( $k =~ m/^[1-9][0-9]*$/ ) {
         return 'Error: Invalid number.';
      }
      # Unless $k is <= length of string, input is invalid:
      my $l = length $s;
      unless ( $k <= $l ) {
         return 'Error: Number is greater than length of string.';
      }
      # Create and initialize a variable to hold the
      # lexicographically-smallest string we can make:
      my $smallest = $s;
      # If $k is 1, then the ONLY strings we can make
      # are the length($s) rotations of $s:
      if ( 1 == $k ) {
         for my $idx (0 .. $l-1) {
            my $rot = substr($s, $idx, $l-$idx) . substr($s, 0, $idx);
            if ($rot lt $smallest) {$smallest = $rot;}
         }
      }
      # Otherwise:
      # If $k is an integer > 1, then any two adjacent letters can be swapped.
      # If any two adjacent letters can be swapped, then any letter can be
      # shuffled to any index. If any letter can be shuffled to any index,
      # then all possible permutations can be created. If all possible
      # permutations can be created, then the lexicographically-smallest word
      # which can be created is always join(sort(split(word))).
      else {
         $smallest = join '', sort split //, $s;
      }
      # Return the lexicographically-smallest string we could make:
      return $smallest;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:

my @inputs = @ARGV
? map {
   $_=~s/^\s+//;
   $_=~s/\s+$//;
   my @a = split /\s+/, $_;
   my $s = shift @a;
   my $k = join ' ', @a;
   [$s, $k];
} @ARGV
: (
   # Example 1 input:
   ["dbca", 1],
   # Expected output: "adbc"

   # Example 2 input:
   ["geeks", 2],
   # Expected output: "eegks"

   # Example 3 input:
   ["cbaed", 3],
   # Expected output: "abcde"

   # Example 4 input:
   ["fedcba", 4],
   # Expected output: "abcdef"

   # Example 5 input:
   ["perl", 1],
   # Expected output: "erlp"

   # Example 6 input:
   ["oloolooo", 1],
   # Expected output: "looloooo"

   # Example 7 input:
   ["oloooolo", 1],
   # Expected output: "looloooo"
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

for my $input (@inputs) {
   my $s = $input->[0];
   my $k = $input->[1];
   my $m = order_characters($s, $k);
   say '';
   say "Original string = $s";
   say "Lexicographically-smallest string we could make = $m";
}
