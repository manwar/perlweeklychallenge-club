#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-08-25
use utf8;     # Week 336 - task 2 - Final score
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

final_score('5', '2', 'C', 'D', '+');
final_score('5', '-2', '4', 'C', 'D', '9', '+', '+');
final_score('7', 'D', 'D', 'C', '+', '3');
final_score('-5', '-10', '+', 'D', 'C', '+');
final_score('3', '6', '+', 'D', 'C', '8', '+', 'D', '-2', 'C', '+');
final_score('C', '1', '2');
final_score('D', '1', '2');
final_score('+', '1', '2');
final_score('1', '+', '2');
final_score('1', 'C', '2', 'C');

sub final_score {
	
	my (@scores, $total, $prev1, $prev2, $score, $i);
	
	say qq[\nInput:  ('] . join(qq[', '], @_) . q[')];	
	
	# get rid of C and scores preceding a C
	$scores[0] = $_[0];
	for ($i = 1; $i < scalar @_; $i ++) {
		if ($_[$i] eq 'C') {
			pop @scores;
		} else {
			push @scores, $_[$i];
		}
	}
	
	# bad input
	if (scalar @scores == 0 or $scores[0] !~ m|^-?\d+$| or $scores[1] eq '+') {
		say qq[Output: bad data];
		return;
	}

	# handle D and +
	for $i (1 .. $#scores) {
		if ($scores[$i] eq '+' and $i >= 2) { 
			$scores[$i] = $scores[$i - 1] + $scores[$i - 2];
		} elsif ($scores[$i] eq 'D') { 
			$scores[$i] = $scores[$i - 1] * 2;
		}
	}
	$total += $_ for @scores;
	say qq[Output: $total];
}
