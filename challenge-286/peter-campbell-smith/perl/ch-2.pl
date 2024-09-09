#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-09
use utf8;     # Week 286 - task 2 - Order game
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my ($minmax, @mm);
@mm = qw(min max);

order_game(2, 1, 4, 5, 6, 3, 0, 2);
order_game(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8);

# larger example
my ($j, @ints);
@ints[$_] = int(rand(50)) for 0 .. 31;
order_game(@ints);

sub order_game {
	
	my (@ints, $m, $n, $op, $e);
	
	# initialise
	@ints = @_;
	$minmax = 0;
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . ')';
	
	# loop over operations
	$n = @ints;
	while ($n >= 2) {
		$e .= qq[\n\nOperation ] . ++ $op . ':';
		
		# loop over pairs
		for ($m = 0; $m < $n; $m += 2) {
			$e .= qq[\n   $mm[$minmax]($ints[$m], $ints[$m + 1]) = ];
			$ints[$m / 2] = minmax($ints[$m], $ints[$m + 1]);
			$e .= $ints[$m / 2];
		}		
		$n /= 2;
	}		
	
	# and the answer is ...
	say qq[Output: $ints[0]$e];
}

sub minmax {
	
	$minmax = 1 - $minmax;
	if ($minmax) {
		return $_[0] < $_[1] ? $_[0] : $_[1];
	} else {
		return $_[0] > $_[1] ? $_[0] : $_[1];
	}
}
