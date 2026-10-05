#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 393-1,
written by Robbie Hatley on Sun Oct 04, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 393-1: Pythagoras Multiplied
Submitted by: Ulrich Rieke
You are given a positive integer n. Find the number of all
positive integer triplets (a, b, c) so that a^2 + b^2 = c^2
and a, b and c are integers <= n.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I'll use a pair of nested ranged foreach loops to check all possible (c,a) pairs to see which (if any) need
b values which are positive integers in order for "$a*$a + $b*$b == $c*$c" to be true.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Input is via either default data or @ARGV. If using @ARGV, provide one-or-more space-separated arguments,
each of which must be a small positive integer. For example:

./ch-1.pl 10 20 30 40 50 'invalid input'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;

   # How many positive-integer-sided triangles exist
   # with hypotenuse <= $n?
   sub Pythagoras ( $n ) {
      my $count = 0;
      foreach my $c (5..$n) {
         foreach my $a (1..int($c/sqrt 2)) {          # Only manually check (a,b,c), not (b,a,c).
            my $b_flt = sqrt($c*$c - $a*$a);          # Floating-point estimate of needed $b.
            my $b_int = floor($b_flt + 0.5);          # Nearest integer to needed $b.
            ++$count if abs($b_flt - $b_int) < 5E-11; # Call it an "int" if within floating-point rounding.
         }
      }
      2*$count;                                       # Each (a,b,c) tacitly implies (b,a,c).
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:

my @hypotenuses = @ARGV ? @ARGV : (20,  7,  1, 15, 30);
# Expected outputs :               12   2   0   8  22

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $hypotenuse (@hypotenuses) {
   say '';
   say "Max Hypotenuse = $hypotenuse.";
   if ( $hypotenuse !~ m/^[1-9]\d*$/ || $hypotenuse > 10000 ) {
      warn "Error: Max Hypotenuse must be a positive integer between 1 and 10,000 inclusive.\n";
      next;
   }
   my $count = Pythagoras $hypotenuse;
   say "Number of right triangles = $count.";
}
