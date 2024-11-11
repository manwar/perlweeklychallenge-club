#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-11-11
use utf8;     # Week 295 - task 2 - Jump game
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my (@ints, $best, $path, $best_path);

jump_game(2, 3, 1, 1, 4, 1, 1, 1, 8);
jump_game(2, 3, 0, 4);
jump_game(2, 0, 0, 4);
jump_game(0);
jump_game(10, 0, 0, 0, 0, 0);

# longer example
@ints = ();
push @ints, int(rand(10)) + 1 for 0 .. 49;
jump_game(@ints);

sub jump_game {
	
	my ($start_at);
	
	# initialise
	@ints = @_;
	$best = 1e6;
	$path = '[0] → ';
	$best_path = '';
	
	# solve the challenge
	min_jumps(0, 0, $path);
	
	# report results
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	say qq[Output: ] . ($best == 1e6 ? '-1' : 
		qq[$best jump] . ($best == 1 ? '' : 's') . qq[: path = $best_path]);
	
}

sub min_jumps {
	
	my ($start_at, $jumps, $reached, $s, $path);
	
	($start_at, $jumps, $path) = @_;
	
	# edge case
	if ($ints[$start_at] == 0 and $#ints == 0) {
		$best = 0;
		$best_path = '[0]';
		return;
	}
	
	# otherwise can't go any further if we've hit a 0
	return unless $ints[$start_at] > 0;
	
	# take a jump
	$jumps ++;
	
	# but no use proceeding if we've already found a better one
	return if $jumps >= $best;
	
	# try all possible jumps from here
	for ($s = $ints[$start_at]; $s >= 1; $s --) {
		$reached = $start_at + $s;
		
		# too far
		next if $reached > $#ints;
		
		# reached the last cell; is this the shortest route?
		if ($reached == $#ints) {
			if ($jumps < $best) {
				$best = $jumps;
				$best_path = $path . qq[[$reached]];
			}
			return;
		}
		
		# recurse from where we've reached
		min_jumps($reached + 0, $jumps + 0, $path . qq[[$reached] → ]);
	}
}

