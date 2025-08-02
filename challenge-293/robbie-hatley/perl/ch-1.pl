#!/usr/bin/env -S perl -CSDA

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 293-1,
written by Robbie Hatley on Mon Oct 28, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 293-1: Similar Dominos
Submitted by: Mohammad Sajid Anwar
You are given a list of dominos, @dominos. Write a script to
return the number of dominoes that are "similar" to any other
domino. $dominos[i] = [a, b] and $dominos[j] = [c, d] are
"similar" if either (a = c and b = d) or (a = d and b = c).

Example 1:
Input: @dominos = ([1, 3], [3, 1], [2, 4], [6, 8])
Similar Dominos are $dominos[0], $dominos[1],
so output is 2.

Example 2:
Input: @dominos = ([1, 2], [2, 1], [1, 1], [1, 2], [2, 2])
Similar Dominos are $dominos[0], $dominos[1], $dominos[3],
so output is 3.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This is just a matter of following the instructions.

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of arrays of two double-quoted strings, in proper Perl syntax, like so:
./ch-1.pl '([["3","F"],["A","7"],["9","B"],["F","3"]],[["3","F"],["F","4"],["4","E"]])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;
   use utf8;

   sub sim_dom ($dref1, $dref2) {
      my $a = $$dref1[0];my $b = $$dref1[1];
      my $c = $$dref2[0];my $d = $$dref2[1];
      $a eq $c && $b eq $d || $a eq $d && $b eq $c
      and return 1 or return 0;
   }

   sub num_sim_doms (@dominos) {
      my $num_sim_doms = 0;
      my $n = scalar(@dominos);
      I: for    ( my $i = 0 ; $i < $n ; ++$i ) {
         J: for ( my $j = 0 ; $j < $n ; ++$j ) {
            next J if $i == $j;
            if (sim_dom $dominos[$i], $dominos[$j]) {
               ++$num_sim_doms;
               next I;
            }
         }
      }
      $num_sim_doms;
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @sets = @ARGV ? eval($ARGV[0]) :
(
   [ [1, 3], [3, 1], [2, 4], [6, 8]         ], # Expected output: 2
   [ [1, 2], [2, 1], [1, 1], [1, 2], [2, 2] ], # Expected output: 3
);

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $sref (@sets) {
   my @dominos = @$sref;
   my $num_sim_doms = num_sim_doms(@dominos);
   say '';
   say 'Dominos = (', join(', ', (map {"[\"$_->[0]\", \"$_->[1]\"]"} @dominos)), ')';
   say "Number of similar dominos = $num_sim_doms";
}
