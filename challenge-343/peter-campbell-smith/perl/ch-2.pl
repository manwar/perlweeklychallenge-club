#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-10-13
use utf8;     # Week 343 - task 2 - Champion team
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

champion_team([[0, 1, 1], [0, 0, 1], [0, 0, 0]]);
champion_team([[0, 1, 0, 0], [0, 0, 0, 0], [1, 1, 0, 0], [1, 1, 1, 0]]);
champion_team([[0, 1, 0, 1], [0, 0, 1, 1], [1, 0, 0, 0], [0, 0, 1, 0]] );
champion_team([[0, 1, 1], [0, 0, 0], [0, 1, 0]] );
champion_team([[0, 0, 0, 0, 0], [1, 0, 0, 0, 0], [1, 1, 0, 1, 1], [1, 1, 0, 0, 0], [1, 1, 0, 1, 0]] );

sub champion_team {
	
	my ($m, $n, $most_wins, $team, $result, $wins, $winner);
	
	# initialise
	$m = $_[0];
	$n = @{$m} - 1;
	$most_wins = -1;
	
	# loop over teams
	for $team (0 .. $n) {
		$wins = 0;
		
		# loop over results for total wins
		for $result (0 .. $n) {
			$wins += $m->[$team]->[$result];
		}
		
		# if this is best so far
		if ($wins > $most_wins) {
			$winner = $team;
			$most_wins = $wins;	
			
		# if this equals best so far and this team
		#  beat the current winner
		} elsif ($wins == $most_wins and $m->[$team]->[$winner]) {
			$winner = $team;
		}
	}
	
	# report
	say ''; print_matrix(qq[Input: ], $m);
	say qq[Output: winner is team $winner with $most_wins wins];
}

sub print_matrix {
	
	my ($legend, $matrix, $j);

	# format matrix
	($legend, $matrix) = @_;
	for $j (0 .. @$matrix - 1) {
		print qq{$legend [} . join(', ', @{$matrix->[$j]}) . qq(]);
		say $j == @$matrix - 1 ? '' : ', ';
		$legend = ' ' x length($legend);
	}
}

