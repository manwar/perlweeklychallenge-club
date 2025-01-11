#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 303-2,
written by Robbie Hatley on Wed Jan 08, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 303-2: "Delete and Earn"
Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints. Write a script to
return the maximum number of points you can earn by applying
the following operation some number of times:
Pick any ints[i] and delete it to earn ints[i] points.
Afterwards, you must delete every element equal to
(ints[i] - 1) and every element equal to (ints[i] + 1).

Example #1:
Input: @ints = (3, 4, 2)
Output: 6
Delete 4 to earn 4 points. (Also delete all 3s and 5s.)
Finally delete 2 to earn 2 points.

Example #2:
Input: @ints = (2, 2, 3, 3, 3, 4)
Output: 9
Delete a 3 to earn 3 points. (Also delete all 2s and 4s.)
Delete a 3 again to earn 3 points.
Delete a 3 once more to earn 3 points.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
Like most "minima" and "maxima" problems, this begs for recursion, so as to try all possibilities, seeking
which yields minimum or maximum results. The trick is, whether/how to pass "results so far" to each recursive
level. I think in this case, since we're finding a maximum within integer scores, I'll make a recursive
subroutine "scores" that returns a list of all scores, then feed that list to the "max" function from CPAN
module "List::Util".

--------------------------------------------------------------------------------------------------------------
IO NOTES:
Input is via either built-in variables or via @ARGV. If using @ARGV, provide one argument which must be a
single-quoted array of arrays of integers, in proper Perl syntax, like so:
./ch-2.pl '([0,9,5,8,4,7,6],[-42,0,17,8,-34],[1,3,5,7,9])'

Output is to STDOUT and will be each input followed by the corresponding output.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

use v5.36;
use List::Util qw( max );

   # What scores can be generated from a given list of ints?
   sub scores ($score, @ints) {
      # If we're out of ints, just return the score:
      if (!@ints) {
         return $score;
      }
      # Otherwise, return all scores which can be obtained by
      # selecting each integer in-turn as "next to be removed":
      else {
         my @scores;
         foreach my $i (0..$#ints) {
            # Make local copies of everything:
            my $local_scor = $score;
            my @local_ints = @ints;
            my $local_valu = $local_ints[$i];
            # Reap $local_ints[$i] and add it to score:
            $local_scor += $local_ints[$i];
            splice @local_ints, $i, 1;
            # Examine each remaining element of @local_ints:
            for ( my $j = 0 ; $j <= $#local_ints ; ++$j ) {
               # If $local_ints[$j] is one-less or one-greater
               # than $local_valu, eliminate it:
               if ( 1 == abs($local_ints[$j] - $local_valu) ) {
                  # Eliminate element:
                  splice @local_ints, $j, 1;
                  # Back-track $j because we just shifted the
                  # right portion of @local_ints one-left:
                  --$j;
               }
            }
            # Send $local_scor and @local_ints (even if empty)
            # to next-deeper recursive level of "sub scores",
            # and append return values to @scores:
            push @scores, scores($local_scor, @local_ints);
         }
         # Return scores:
         return @scores;
      }
   }

# ------------------------------------------------------------------------------------------------------------
# INPUTS:
my @arrays = @ARGV ? eval($ARGV[0]) : ([3, 4, 2],[2, 2, 3, 3, 3, 4]);
# Expected output:                         9              11

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:
$"=', ';
for my $aref (@arrays) {
   say '';
   my @ints = @$aref;
   my @scores = scores(0, @ints);
   my $max = max @scores;
   say "Ints = (@ints)";
   say "Scores = (@scores)";
   say "Max Score = $max";
}
