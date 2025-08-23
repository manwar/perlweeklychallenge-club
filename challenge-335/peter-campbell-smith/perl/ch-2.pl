#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-08-18
use utf8;     # Week 335 - task 2 - Find winner
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

find_winner([0,0],[2,0],[1,1],[2,1],[2,2]);
find_winner([0,0],[1,1],[0,1],[0,2],[1,0],[2,0]);
find_winner([0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]);
find_winner([0,0],[1,1]);
find_winner([1,1],[0,0],[2,2],[0,1],[1,0],[0,2]);

sub find_winner {
    
    my ($input, @wins, @moves, $player, @owned, $move, $win, $output, $j, @board);
	
	# initialise
	@moves = @_;
	$player = 0;
	@owned = (0, 0);
	$board[$_] = '_' for 0 .. 8;
	
	# the 8 winning patterns
	@wins = (0b111000000, 0b000111000, 0b000000111,
			 0b100100100, 0b010010010, 0b001001001,
			 0b100010001, 0b001010100);
	
	# loop over moves and set player as owning the cell
	for $move (@moves) {
		$owned[$player] |= (2 ** (3 * $move->[0] + $move->[1]));
		$board[$move->[1] + 3 * $move->[0]] = chr(ord('A') + $player);
		$player = 1 - $player;
	}
	
	# check to see if this move makes a win
	for $win (@wins) {
		for $j (0, 1) {
			if (($win & $owned[$j]) == $win) {
				$output = chr(ord('A') + $j) . ' wins';
				last;
			}
		}
	}
	
	# draw if no win with 9 moves or pending id <9 moves
	$output = scalar @moves == 9 ? 'Draw' : 'Pending' unless $output;
    
    # report
	$input .= qq{[$_->[0], $_->[1]], } for @moves;
    say qq[\nInput:  ] . substr($input, 0, -2); 
    say qq[Output: $output];
	
	# show board
	say qq{        [ $board[0] $board[1] $board[2] ]\n} .
		qq{        [ $board[3] $board[4] $board[5] ]\n} .
		qq{        [ $board[6] $board[7] $board[8] ]};
}