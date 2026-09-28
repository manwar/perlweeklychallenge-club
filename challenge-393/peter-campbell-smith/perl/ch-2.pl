#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-09-28
use utf8;     # Week 393 - task 2 - Prime step
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Math::Prime::Util 'is_prime';
use Encode;

prime_step('football');
prime_step('hello');
prime_step('challenge');
prime_step('supercalifragilisticexpialidocious');
prime_step('ⱠⱡⱢⱣⱤⱥⱦ');

sub prime_step {
	
	my ($string, $answer, $j, $sum, $explain, $above, $below);
	
	$string = $_[0];
	$answer = -1;
	$below = $above = 0;
	
	# sum the ordinal values of the string
	$sum += ord($_) for split(//, $string);
	
	# work up and down until we find a prime
	for $j (0 .. 1000) {
		$below = $j if is_prime($sum - $j);
		$above = $j if is_prime($sum + $j);
		
		# found surrounding primes
		if ($below and $above) {
			$answer = ($below < $above) ? $below : $above;
			$explain = qq[sum = $sum: primes below and above = ] . 
				($sum - $below) . ', ' . ($sum + $above);
			last;
		}
	}
	
	say qq[\nInput:  '$string'];
	say qq[Output: $answer\n     $explain];	
}

