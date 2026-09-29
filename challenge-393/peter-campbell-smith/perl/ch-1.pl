#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-09-28
use utf8;     # Week 393 - task 1 - Pythagoras multiplied
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

pythagoras_multiplied(20);
pythagoras_multiplied(1);
pythagoras_multiplied(50);
pythagoras_multiplied(1000);

sub pythagoras_multiplied {
	
	my ($n, $n2, $max_a, $count, $b2, $explain, $c, $a2, %square);
	
	# initialise
	$n = $_[0];
	$count = 0;
	$explain = '';
	$n2 = $n ** 2;
	$max_a = int($n2 / 2);
	
	# make list of squares
	$square{$_ ** 2} = 1 for 3 .. $n;
	
	# loop over possible $a ($a < $b)
	A: for $a (3 .. $max_a) {
		$a2 = $a ** 2;
		
		# loop over possible $b
		B: for $b ($a + 1 .. $n - 3) {
			$b2 = $b ** 2;
			
			# $b is too big for this $a
			next A if $a2 + $b2 > $n2;
			
			# $c isn't a square
			next B unless $square{$a2 + $b2};
			
			# we have 2 solutions
			$count += 2;
			$c = sqrt($a ** 2 + $b ** 2);
			$explain .= qq[($a, $b, $c), ($b, $a, $c), ];
			next A;
		}
			
	}
	say qq[\nInput:  $n];
	say qq[Output: $count];
	say substr($explain, 0, -2) if $count;
}
