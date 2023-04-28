#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-04-24
use utf8;     # Week 214 task 1 - Rank score
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

rank_score(8, 5, 7, 6, 4);
rank_score(8, 5, 7, 6, 5, 4);
rank_score(1, 2, 2, 2, 3);
rank_score(1, 12, 123, 1234, 1234, 2);

sub rank_score {
	
	my (@scores, $num_players, @rank_symbols, @ranks, $s, $score, $rank, $prev, @sorted, $p,
		$rubric1, $rubric2, $w);
	
	# process input
	@scores = @_;
	$num_players = scalar @scores - 1;
	
	# create rank symbols - GBS456 ...
	$rank_symbols[$num_players - $_] = $_ > 2 ? $_ + 1: substr('GSB', $_, 1) for (0 .. $num_players);

	# loop over players sorted by score
	@sorted = sort {$a <=> $b} @scores;
	$w = 0;
	for ($s = 0; $s <= $num_players; $s ++) {
		
		# assign rank symbol to score
		$ranks[$sorted[$s]] = $rank_symbols[$s];
		
		# deal with tied place
		$ranks[$sorted[$s]] .= '=' if ($s > 0 and $sorted[$s] == $sorted[$s - 1]);
		
		# find largest width for neat printout
		$w = length($sorted[$s]) if $w < length($sorted[$s]);
		$w = length($ranks[$sorted[$s]]) if $w < length($ranks[$sorted[$s]]);
	}
	
	# show answers
	for ($p = 0; $p <= $num_players; $p ++) {
		$rubric1 .= sprintf("%${w}s, ", $scores[$p]);
		$rubric2 .= sprintf("%${w}s, ", $ranks[$scores[$p]]);
	}
	say qq[\nInput:  ] . substr($rubric1, 0, -2);
	say qq[Output: ] . substr($rubric2, 0, -2);
}