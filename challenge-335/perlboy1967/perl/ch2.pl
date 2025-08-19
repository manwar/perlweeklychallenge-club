#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-335#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Find Winner
Submitted by: Mohammad Sajid Anwar

You are given an array of all moves by the two players.

Write a script to find the winner of the TicTacToe game if found based on
the moves provided in the given array.

UPDATE: Order move is in the order - A, B, A, B, A, ...

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub findWinner (@moves) {
  # Define winner regexp ($+{w} is the winner)
  state $re = qr/
    ^(?<w>AAA|BBB)          | # Row 1
    ^... (?<w>AAA|BBB)      | # Row 2
    ^... ... (?<w>AAA|BBB)  | # Row 3
    ^(?<w>[AB]).. \4.. \4   | # Column 1
    ^.(?<w>[AB]). .\5. .\5  | # Column 2
    ^..(?<w>[AB]) ..\6 ..\6 | # Column 3
    ^(?<w>[AB]).. .\7. ..\7 | # Diagonal 1
    ^..(?<w>[AB]) .\8. \8     # Diagonal 2 
 /x;

 # Initialise the board
 my $board = '_' x 9;

 # Initialise the turns
 my @turns = qw(A B A B A B A B A);

 for (@moves) {
   substr($board, $_->[0] * 3 + $_->[1], 1, shift @turns);
 }

 return substr($+{w}, 0, 1) if ($board =~ $re);
 return 'Pending' if (@moves < 9);
 return 'Draw';
}

is findWinner([0,0],[2,0],[1,1],[2,1],[2,2]),'A','Example 1 (A wins)';
is findWinner([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]),'B','Example 2 (B wins)';
is findWinner([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]),'Draw','Example 3 (Draw)';
is findWinner([0,0],[1,1]),'Pending','Example 4 (Pending)';
is findWinner([1,1],[0,0],[2,2],[0,1],[1,0],[0,2]),'B','Example 5 (B wins)';

done_testing;
