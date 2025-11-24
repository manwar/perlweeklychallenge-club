#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given instruction string made up of U (up), D (down), L (left) and R (right).

Write a script to return true if following the instruction, you meet the starting point (0,0).

Example 1

Input: $path = "ULD"

Output: false

(-1,1) <- (0,1)
   |        ^
   v        |
(-1,0)    (0,0)


Example 2

Input: $path = "ULDR"
Output: true

 (-1,1) <- (0,1)
    |        ^
    v        |
 (-1,0) -> (0,0)


Example 3

Input: $path = "UUURRRDDD"
Output: false

(0,3) -> (1,3) -> (2,3) -> (3,3)
  ^                          |
  |                          v
(0,2)                      (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0)                      (3,0)


Example 4
Input: $path = "UURRRDDLLL"
Output: true

(0,2) -> (1,2) -> (2,2) -> (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0) <- (1,0) <- (1,1) <- (3,0)


Example 5

Input: $path = "RRUULLDDRRUU"
Output: true

(0,2) <- (1,2) <- (2,2)
  |                 ^
  v                 |
(0,1)             (2,1)
  |                 ^
  v                 |
(0,0) -> (1,0) -> (2,1)
=cut

use constant { true => 1, false => 0 };
use Test2::V0 -no_srand => 1;

is(meeting_point("ULD"), false, 'Example 1');
is(meeting_point("ULDR"), true, 'Example 2');
is(meeting_point("UUURRRDDD"), false, 'Example 3');
is(meeting_point("UURRRDDLLL"), true, 'Example 4');
is(meeting_point("RRUULLDDRRUU"), true, 'Example 5'); # does not necessarily end at (0,0).

done_testing();

sub meeting_point
{
     my $path = $_[0];
     my %dirs = ( 'U' => [0,  1],
                  'D' => [0, -1],
                  'L' => [-1, 0],
                  'R' => [ 1, 0]);
     my $x = my $y = 0;
     for my $step ( split(//, $path) )
     {
          $x += $dirs{$step}->[0];
          $y += $dirs{$step}->[1];
          if ( $x == 0 and $y == 0 )
          {
               return true; # meet the starting point.
          }
     }
     return false;
}
