#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-02-16
use utf8;     # Week 361 - task 1 - Zeckendorf representation
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

zeckendorf_representation(4);
zeckendorf_representation(12);
zeckendorf_representation(20);
zeckendorf_representation(96);
zeckendorf_representation(100);
zeckendorf_representation(10_000_000);

sub zeckendorf_representation {
	
	my ($integer, $remains, @fib, $n, $f, $explain);
	
	# initialise
	$integer = $_[0];
	$remains = $integer;
	
	# create Fibonacci series up to $integer
	$fib[0] = $fib[1] = 1;
	$n = 1;
	do {
		$n ++;
		$fib[$n] = $fib[$n - 1] + $fib[$n - 2];
	} until ($fib[$n] > $integer);

	# repeatedly subtract qualifying fibonacci term
	for ($f = $n - 1; $f >= 0; $f --) {
		if ($fib[$f] > 0
		and ($fib[$f + 1] > 0)
		and ($f > 0 and $fib[$f - 1] > 0)
		and $remains >= $fib[$f]) {
			
			# can use this term
			$remains -= $fib[$f];
			$explain .= qq[$fib[$f] + ];
			$fib[$f] = -1;
			last unless $remains;
		}
	}		
	
	# report
	say qq[\nInput:  $integer];
	say qq[Output: ] . substr($explain, 0, -3);
}
