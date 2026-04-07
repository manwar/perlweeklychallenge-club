#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 368-2,
written by Robbie Hatley on Mon Apr 06, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 368-2: Big and Little Omega
Submitted by: Roger Bell_West
You are given a positive integer $number and a mode flag $mode.
If the mode flag is zero, calculate little omega (the count of
all distinct prime factors of that number). If it is one,
calculate big omega (the count of all prime factors including
duplicates).

Example #1:
Input: $number = 100061
$mode = 0
Output: 3
Prime factors are 13, 43, 179. Count is 3.

Example #2:
Input: $number = 971088
$mode = 0
Output: 3
Prime factors are 2, 2, 2, 2, 3, 20231.
Count of distinct numbers is 3.

Example #3:
Input: $number = 63640
$mode = 1
Output: 6
Prime factors are 2, 2, 2, 5, 37, 43.
Count including duplicates is 6.

Example #4:
Input: $number = 988841
$mode = 1
Output: 2

Example #5:
Input: $number = 211529
$mode = 0
Output: 2

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
To solve this problem, I'll need a short, fast "factor" algorithm. Then just use "scalar" to count all
factors, and "scalar uniq" to count unique factors.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays, with each inner array consisting of a positive integer followed by a 0 or 1,
in proper Perl syntax, like so:

./ch-2.pl '([395738, 0], [29464, 1])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8::all;
   use List::Util 'uniq';

   # Determine all prime factors
   # of a positive integer $n:
   sub factor ($n) {
      my @factors;
      my $r = $n;
      while ( 0 == $r % 2 ) {
         push @factors, 2;
         $r /= 2
      }
      for (my $i = 3; $i * $i <= $r; $i += 2) {
         while ( 0 == $r % $i ) {
            push @factors, $i;$r /= $i}}
      push @factors, $r if $r > 1;
      return @factors}

   # Calculate big or little omega of $n,
   # depending on flag $f:
   sub omega ( $n, $f ) {
      my @factors = factor $n;
      $f and return scalar @factors
      or return scalar uniq @factors}

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) :
(
   [ 100061, 0 ], # 3
   [ 971088, 0 ], # 3
   [  63640, 1 ], # 6
   [ 988841, 1 ], # 2
   [ 211529, 0 ], # 2
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my $n = $aref->[0];
   my $f = $aref->[1];
   say "Number = $n  Flag = $f";
   my $o = omega($n, $f);
   $f and say "Big Omega = $o"
      or  say "Little Omega = $o";
}
