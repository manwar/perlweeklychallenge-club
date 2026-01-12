#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-01-12
use utf8;     # Week 356 - task 2 - Who wins?
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

who_wins(['Detroit', 'Philadelphia', 'Tampa Bay', 
	'Los Angeles Rams', 'Minnesota', 'Washington', 
	'Green Bay'], 'HAHAHH');
	
who_wins(['Kansas City', 'Buffalo', 'Baltimore', 
	'Houston', 'Los Angeles Chargers', 'Pittsburgh', 
	'Denver'], 'HHHHHH');
	
who_wins(['Tennessee', 'Kansas City', 'Buffalo', 
	'Cincinnati', 'Las Vegas', 'New England', 
	'Pittsburgh'], 'HHHAHA');
	
who_wins(['Green Bay', 'Tampa Bay', 'Dallas',
	'Los Angeles Rams', 'Arizona', 'San Francisco',
	'Philadelphia'], 'HAHAAH');
	
who_wins(['Green Bay', 'New Orleans', 'Seattle',
	'Washington', 'Tampa Bay', 'Los Angeles Rams', 
	'Chicago'], 'HAAHAA');

sub who_wins {
	
	my (@teams, @results, @winner);
	
	# initialise
	@teams = @{$_[0]};
	unshift(@teams, '');
	@results = split('', qq[x$_[1]]);
	
	# wild card playoffs
	$winner[0] = 1;
	$winner[1] = $results[1] eq 'H' ? 2 : 7;
	$winner[2] = $results[2] eq 'H' ? 3 : 6;
	$winner[3] = $results[3] eq 'H' ? 4 : 5;
	
	# divisional playoffs
	@winner = sort {$a <=> $b} @winner;
	$winner[4] = $results[4] eq 'H' ? $winner[0] : $winner[3];
	$winner[5] = $results[5] eq 'H' ? $winner[1] : $winner[2];
	
	# final
	@winner = sort {$a <=> $b} @winner[4 .. 5];
	$winner[6] = $results[6] eq 'H' ? $winner[0] : $winner[1];
		
	# ... and the winnner is ...
	say qq[\nInput:  \@teams = ] . join(', ', @teams[1 .. 7]) .
		qq[\n        \$results = ] . join('', @results[1 .. 6]);
	say qq[Output: $teams[$winner[0]] played $teams[$winner[1]]] .
		qq[ and $teams[$winner[6]] won];
}
