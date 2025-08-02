#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-08-05
use utf8;     # Week 281 - task 2 - Knight's move
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

knights_move('g2', 'a8');
knights_move('g2', 'h2');
knights_move('a1', 'h8');
knights_move('e3', 'e4');

sub knights_move {
	
	my (@valid_moves, $from_square, $to_square, %from, $moves, $square, $v,
		$trace, $square2, $x, $y, $s, %m, $next_square);
	
	# x, y changes for valid moves
	@valid_moves = ([-2, 1], [-1, 2], [1, 2], [2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]);
	
	# initialise
	$from_square = $_[0];
	$to_square = $_[1];
	say qq[\nInput:  \$start = '$from_square', \$end = '$to_square'];
	
	for $x ('a' .. 'h') {
		for $y (1 .. 8) {
			$from{$x . $y} = '';
			$m{$x . $y} = -1;
		}
	}
	$from{$from_square} = 0;
	$m{$from_square} = 0;
	
	# find squares $moves away from starting square
	for $moves (1 .. 10) {
		
		# look at every square
		for $s (0 .. 63) {
			
			# select those accessible in $moves - 1 moves
			$square = chr(ord('a') + $s % 8) . (int($s / 8) + 1);
			if ($m{$square} == $moves - 1) {
				
				# mark squares accessible from them
				for $v (@valid_moves) {
					$next_square = displace($square, $v);
					next if $next_square eq 'invalid';
					next unless $from{$next_square} eq '';
					
					# we've arrived!
					if ($next_square eq $to_square) {
						$trace = $to_square;
						$square2 = $square;
						while (1) {
							$trace = $square2 . qq[ → $trace];
							last if $square2 eq $from_square;
							$square2 = $from{$square2};
						} 
						say qq[Output: $moves ($trace)];
						return;
					}
					$from{$next_square} = $square;
					$m{$next_square} = $moves;
				}
			}
		}
	}
}

sub displace {
	
	my (@square, $x, $y);
	
	# displace($square, $x, $y) returns square displaced by those increments
	($x, $y) = $_[0] =~ m|(.)(.)|;
	@square = @{$_[1]};
	
	$x = chr(ord($x) + $square[0]);
	$y = $y + $square[1];
	return ($x lt 'a' or $x gt 'h' or $y < 1 or $y > 8) ? 'invalid' : $x . $y;
}	
