#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-10-21
use utf8;     # Week 292 - task 2 - Zuma game
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my ($best, $end, $best_trace);

zuma_game('WRRBBW', 'RB');
zuma_game('WWRRBBWW', 'WRBRW');
zuma_game('G', 'GGGGG');
zuma_game('RRGGBBYYPPOO', 'RGBYPO');
zuma_game('11223344556654321', '76');
zuma_game('abcdefghhgfedcba', 'hgfedcba');

sub zuma_game {
	
	my ($row, $hand);
	
	($row, $hand) = @_;
	
	# start game
	say qq[\nInput:  \$row = '$row', \$hand = '$hand'];
	
	# eliminate impossible row/hand combos
	unless (impossible($row, $hand)) {
	
		# play the game
		$best = 9999;
		$end = '¦';
		zuma_game_play($row, $hand, 0, "$row $hand, ");
		
		# analyse result
		($row, $hand) = $end =~ m|(.*)¦(.*)|;
		if ($row eq '' and $best != 9999) {
			say qq[Output: $best move] . ($best == 1 ? '' : 's');
			say qq[   row '$1' hand '$2'] while $best_trace =~ m|([A-Z0-9]+) ([A-Z0-9]+),|gi;
			say qq[   row '' hand '$hand'];
		} else {
			say qq[Output: -1];
		}
	}
}

sub impossible {
	
	my ($row, $hand, $c, %rows, %hands);
	
	# eliminate obviously impossible hand/row combinations
	($row, $hand) = @_;
	$rows{$_} ++ for split(//, $row);
	$hands{$_} ++ for split(//, $hand);
	for $c (keys %rows) {
		
		# if char occurs once in row and zero or once in hand ...
		if ($rows{$c} == 1 and (not defined $hands{$c} or $hands{$c} == 1)
		
			# ... or twice in row but not at all in hand
			or $rows{$c} == 2 and not defined $hands{$c}) {
				
			# no solution exists
			say qq[Output: -1];
			return 1;
		}
	}
	return 0;
}

sub zuma_game_play {
	
	my ($n, $row, $hand, $so_far, $l_row, $l_hand, $h, $h_colour, %tried_colour, $new_hand,
		$new_row, $r, $hand_char, %tried, $trace);
	
	($row, $hand, $so_far, $trace) = @_;
	
	# abandon this trial as we already have an as-good or better one
	return if $so_far >= $best;
	
	# clear out 3+ segments from $row
	do {
		$n = $row =~ s|(.)\1\1+||g;
	} until ($n == 0);
	
	# are we done?
	$l_row = length($row);
	$l_hand = length($hand);
	if ($l_row == 0) {
		
		# yes!
		if ($so_far < $best) {
			$best = $so_far;
			$end = qq[¦$hand];
			$best_trace = $trace;
			return;
		}
	}
	
	# can't pursue this line of testing as nothing is left in hand
	return if $l_hand == 0;
	
	# try moving any useful ball from hand to row
	%tried_colour = ();
	for $h (0 .. $l_hand - 1) {
		
		# try each colour only once, and only if it exists in row
		$hand_char = substr($hand, $h, 1);
		next unless $row =~ m|$hand_char|;
		next if $tried_colour{$hand_char};
		$tried_colour{$hand_char} = 1;
		
		# create new trial hand by removing char from hand ...
		$new_hand = $h == 0 ? '' : substr($hand, 0, $h);
		$new_hand .= substr($hand, $h + 1) unless $h + 1 == $l_hand;
		
		# ... and putting it in all sensible positions in trial row
		for $r (0 .. $l_row) {
			next unless substr($row, $r, 1) eq $hand_char;
			next if $r > 0 and substr($row, $r, 1) eq substr($row, $r - 1, 1);
			$new_row = '';
			$new_row .= substr($row, 0, $r) unless $r == 0;
			$new_row .= $hand_char;
			$new_row .= substr($row, $r);
			next if $tried{qq[$new_row¦$new_hand]};
			$tried{qq[$new_row¦$new_hand]} = 1;
			
			# and keep going
			zuma_game_play($new_row, $new_hand, $so_far + 1, qq[$trace $new_row $new_hand, ]);
		}
	}
}

