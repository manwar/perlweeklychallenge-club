#! /bin/perl

########################################################################
# Robbie Hatley's Perl solution to The Weekly Challenge 210-2          #
# Written 2023-03-29 by Robbie Hatley.                                 #
########################################################################

=pod

PROBLEM DESCRIPTION:

Task 2: Number Collision
Submitted by: Mohammad S Anwar
You are given an array of integers which can move to the right if they 
are positive or to the left if they are negative. If two of these 
integers collide, then the one with the smaller absolute value will 
explode. If both have same absolute value, then they both explode. 
All numbers move at the same speed, therefore any 2 numbers moving in 
the same direction will never collide. Write a script to find out who 
survives the collision.
Example 1:  Input: (2, 3, -1)  Output: (2, 3)
Example 2:  Input: (3, 2, -4)  Output: (-4)
Example 3:  Input: (1, -1)     Output: ()

NOTE RH 2023-03-29: If one-or-more zeros are present, then one has to 
make some assumptions, because the rules don't specify what to do about 
zeros. After thinking about it, I realized there are (at least) 15 
different ways to interpret 0. Firstly, are they left-moving, 
stationary, or right-moving? And for each of those, when they collide, 
do they ghost, block, destroy other, destroy self, or destroy both? 
That's 3x5=15 possibilities. 

For my solution I'll assume that zeros are "moving rightward", because 
the rules say "all numbers move at same speed", and speed is absolute 
value of velocity, so zeros must move at either +v or -v. Because zeros 
are conceptually closer to being positive than negative (because 
"natural numbers" includes zero and positive integers, but not negative 
integers), I'll assume +v. 

I'll also assume that zeros "collide" rather than "ghost" or "block" 
when they come into contact with other numbers, because the rules 
mention only "collision" as a possible way for these integers to 
interact. 

I'll also assume:
0 + 0 => both explode, because equal absolute value
0 + positive => 0 explodes because it has less abs. val.
0 + negative => 0 explodes because it has less abs. val. 

I think I'll torture a 3-part loop into doing what I want:
Start at 1 and see if previous+current will collide.
If destroy current only, splice and backtrack 1.
If destroy previous or both, splice and backtrack 2.
++$i at top of loop and keep looping while $i <= $#_ .

INPUT / OUTPUT NOTES:

Input is from built-in array of arrays, or from @ARGV. If using @ARGV,
input should be an array of arrays of integers in proper Perl syntax,
surrounded by 'single quotes', like so:
./ch-1.pl '([-7,-6,0,12,-13],[-4,0,14,6,-7])'

Output will be to STDOUT and will be "surviving integers".

=cut

# PRELIMINARIES:
use v5.32;
use strict;
use warnings;
use List::Util 'sum0';

# DEFAULT INPUTS:
my @arrays = 
(
   [2,3,-1],
   [3,2,-4],
   [1,-1],
   [-7,-6,0,12,-13],
   [-4,0,14,6,-7]
);

# NON-DEFAULT INPUTS:
if (@ARGV) {@arrays = eval($ARGV[0])}

# MAIN BODY OF SCRIPT:
say '';
say 'Let the integer collisions commence.';
for (@arrays){
   # Announce original integer list:
   say '';
   say "Integer list: (@$_)";

   # Riffle through the list, generally going from left to right, but
   # backtracking as necessary to chase "sinking" negatives and process
   # their collisions:
   for ( my $i = 1 ; $i <= $#$_ ; ++$i ){
      next if $i < 1; # This may happen if we destroy both prev and curr
      # Are previous and current about to collide?
      if ( $_->[$i-1] >= 0 && $_->[$i] < 0 ){
         # If previous has greater absolute value, destroy current only:
         if    ( $_->[$i-1]  > -$_->[$i] ){
            splice @$_, $i, 1;
            --$i; # Backtrack 1 because removed current item.
         }
         # If previous and current have equal absolute value, destroy both:
         elsif ( $_->[$i-1] == -$_->[$i] ){
            splice @$_, $i-1, 2;
            --$i; --$i; # Backtrack 2 because removed previous and current items.
         }
         # If current has greater absolute value, destroy previous only:
         elsif ( $_->[$i-1]  < -$_->[$i] ){
            splice @$_, $i-1, 1;
            --$i; --$i; # Backtrack 2 because removed previous item.
         }
      }
   }

   # Announce remnants of original array:
   say "Remaining:    (@$_)";
}
