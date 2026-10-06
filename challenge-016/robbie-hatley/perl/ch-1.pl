#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:

Solution in Perl for The Weekly Challenge 016-1,
written by Robbie Hatley on Tue Oct 06, 2026.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:

Task 016-1: Pythagoras Pie Puzzle
Proposed by Jo Christian Oterhals.
At a party a pie is to be shared by 100 guests. The first guest
gets 1% of the pie, the second guest gets 2% of the remaining
pie, the third gets 3% of the remaining pie, the fourth gets 4%,
and so on. Write a script that figures out which guest gets the
largest piece of pie.

(See "# INPUTS:" section below for examples.)

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:

I'll just perform the calculations described and see what happens.

--------------------------------------------------------------------------------------------------------------
IO NOTES:

Any inputs will be ignored, because no inputs are required.

Output is to STDOUT and will a list of pie portions received by each of the 100 guests, followed by
a statement of which guest got the largest piece and how much hir got.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.40;
   $"=', ';
   my $pie          = 1  ;
   my @portions     = () ;
   my $max_portion  = 0  ;
   my $max_guest    = 0  ;
   for my $guest ( 1 .. 100 ) {
      my $portion = ($guest/100)*$pie;
      $pie -= $portion;
      push @portions, $portion;
      if ( $portion > $max_portion ) {
         $max_portion = $portion;
         $max_guest   = $guest;
      }
   }
   say "Portions = (@portions)";
   say "Guest $max_guest got the biggest portion, which was $max_portion";
