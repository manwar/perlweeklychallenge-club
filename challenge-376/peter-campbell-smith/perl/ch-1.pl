#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-06-01
use utf8;     # Week 376 - task 1 - Chessboard squares
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

chessboard_squares('a7', 'f4'); # true
chessboard_squares('c1', 'e8'); # false
chessboard_squares('b5', 'h2'); # false
chessboard_squares('f3', 'h1'); # true
chessboard_squares('a1', 'g8'); # false
chessboard_squares('a8', 'h1'); # true
chessboard_squares('a1', 'h8'); # true

sub chessboard_squares {
	
	my ($c1, $c2, $a1, $a2);
	
	# initialise
	($c1, $c2) = @_;
	
	# if row + col is even then black (0), else white (1)
	$a1 = ord(substr($c1, 0, 1)) + substr($c1, 1, 1);
	$a2 = ord(substr($c2, 0, 1)) + substr($c2, 1, 1);

	# if $a1 + $a2 is even then colours are different else the same
	say qq[\nInput:  \$c1 = '$c1', \$c2 = '$c2'];
	say qq[Output: ] . ((($a1 + $a2) & 1) ? 'false' : 'true');
}

