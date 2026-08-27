#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solution in Perl for The Weekly Challenge 388-2,
written by Robbie Hatley on Tue Aug 25, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 388-2: Secret Santa
Submitted by: Roger Bell_West
A company with $n employees is running a Secret Santa exchange.
Each employee buys one gift and receives one gift.
Write a script to return the total number of valid gift
assignments where no employee receives the gift they originally
bought (i.e., employee $i must not be assigned gift $i).

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
The number of Secret Santa arrangements for n persons is the nth Pierre Remond de Montmort number,
which is the number of derangements of n items. The "derangements" function of CPAN module
"Algorithm::Combinatorics" generates the correct number of arrays for all non-negative integers.
(Sadly, CPAN module "Math::Combinatorics" does NOT give the correct answers for the "0" and "1" cases.)

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one-or-more space-separated
arguments which must be non-negative integers. For example:

./ch-2.pl 0 1 2 3 4 5 6

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.42;
   use utf8::all;
   use Algorithm::Combinatorics 'derangements';
   $"=', ';

   # How many derangements of 0..$n-1 exist?
   sub Pierre_Remond_de_Montmort ( $n ) {
      my @p = (0..$n-1);
      my @d = derangements(\@p);
      return scalar @d;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @numbers = @ARGV ? @ARGV : ( 0,   1,   2,   3,   4,   5,   6 );
#           Expected outputs:   1    0    1    2    9   44  265

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
for my $number (@numbers) {
   my $d = Pierre_Remond_de_Montmort($number);
   say "For $number persons there are $d valid Secret Santa arrangements.";
}
