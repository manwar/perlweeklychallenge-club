#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 356-1,
written by Robbie Hatley on Dow Mon Dm, 2025.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 356-1: Kolakoski Sequence
Submitted by: Mohammad Sajid Anwar
You are given an integer, $int > 3.
Write a script to generate the Kolakoski Sequence of given
length $int and return the count of 1 in the generated sequence.
Please follow the wikipedia page for more informations.

Example #1:
Input: $int = 4
Output: 2
(1)(22)(11)(2) => 1221

Example #2:
Input: $int = 5
Output: 3
(1)(22)(11)(2)(1) => 12211

Example #3:
Input: $int = 6
Output: 3
(1)(22)(11)(2)(1)(22) => 122112

Example #4:
Input: $int = 7
Output: 4
(1)(22)(11)(2)(1)(22)(1) => 1221121

Example #5:
Input: $int = 8
Output: 4
(1)(22)(11)(2)(1)(22)(1)(22) => 12211212

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I simply use the generative formula given by the Wikipedia article on
"Kolakoski Sequence":
1. Start with interation index i=1.
2. Let sequence k be Kolakoski Sequence
3. Let sequence r be the sequence of run lengths.
4. For each iteration i
      if k[i] has been defined
         set r[i] = k[i]
      otherwise
         set r[i] = i
5. If i is odd
      push r[i] copies of '1' as elements to the right end of sequence k
   otherwise
      push r[i] copies of '2' as elements to the right end of sequence k

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of positive integers greater than 3, in proper Perl syntax, like so:

./ch-1.pl '(15, 37, 56)'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;

   # Generate the first $n terms of The Kolakoski Sequence:
   sub Kolakoski ( $n ) {
      # Start with interation index i=1:
      my $i = 1;
      # Let sequence k be Kolakoski Sequence:
      my @k = (0); # Perl uses 0-indexing.
      # Let sequence r be the sequence of run lengths:
      my @r = (0); # Perl uses 0-indexing.
      # For each iteration i:
      foreach $i ( 1 .. $n ) {
         # if k[i] has been defined, set r[i] = k[i]:
         if ( defined $k[$i] ) {
            $r[$i] = $k[$i];
         }
         # otherwise, set r[i] = i:
         else {
            $r[$i] = $i;
         }
         # If i is odd, push r[i] copies of '1' to k:
         if ( 1 == $i % 2 ) {
            push @k, (1)x$r[$i];
         }
         # Otherwise, push r[i] copies of '2' to k:
         else {
            push @k, (2)x$r[$i]
         }
         # Stop if k now has n-or-more elements:
         last if scalar(@k) >= $n+1; # Account for 0.
      }
      # Output the sum of the "1" elements within
      # the first n elements of k:
      my $sum = 0;
      foreach $i ( 1 .. $n ) {
         if ( 1 == $k[$i] ) {
            ++$sum;
         }
      }
      $sum;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @ints = @ARGV ? eval($ARGV[0]) : (4,5,6,7,8);
# Expected outputs                :  2,3,3,4,4

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $int (@ints) {
   say '';
   my $sum = Kolakoski($int);
   say "The first $int elements of The Kolakoski Sequence contain $sum instances of \"1\".";
}
