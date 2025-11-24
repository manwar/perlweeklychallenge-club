#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-11-24
use utf8;     # Week 349 - task 2 - Meeting point
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

meeting_point('ULD');
meeting_point('ULDR');
meeting_point('UUURRRDDD');
meeting_point('UURRRDDLLL');
meeting_point('RRUULLDDRRUU');

sub meeting_point {
	
	my (@moves, %shift, $x, $y);
	
	# initialise
	@moves = split('', $_[0]);
	%shift = (R => '$x++', L => '$x--', U => '$y++', D => '$y--');
	$x = $y = 0;
	
	# apply moves
	for (@moves) {
		eval($shift{$_});
		last if ($x == 0 and $y == 0);
	}
	
	say qq[\nInput:  $_[0]];
	say qq[Output: ] . ($x == 0 && $y == 0 ? 'true' : 'false');
}
