#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-10-30
use utf8;     # Week 241 task 2 - Prime order
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

my (@sieve, $j, @int, $next, $count, @used);

prime_order(11, 8, 27, 4);

# bigger example: 30 unique numbers in (2 .. 500)
$count = 0;
while ($count < 30) {
	$next = int(rand(501));
	next if $used[$next] or $next < 2;
	push(@int, $next);
	$count ++;
	$used[$next] = 1;
}
prime_order(@int);	

sub prime_order {
	
	my (@int, $largest, $i, $count, $list, %output, $k, $explain, $ordered);
	
	# initialise
	@int = @_;
	
	# find the largest and create sieve of Eratosthenes
	$largest = 0;
	for $i (@int) {
		$largest = $i if $i > $largest;
	}
	make_sieve($largest);
	
	# loop over @int, get prime factors and provide key to sort in desired order
	for ($i = 0; $i < @int; $i ++) {
		($count, $list) = prime_factors($int[$i]);
		$output{sprintf('%08d~%08d', $count, $int[$i])} = $list;
	}
	
	# extract sorted results and prepare to display
	$explain = '';
	$ordered = '';
	for $k (sort keys %output) {
		$k =~ m|(\d+)~(\d+)|;
		$i = $2 + 0;
		$ordered .= qq[$i, ];
		$explain .= sprintf(qq[         Prime factors of %3d => %s\n], $i, $output{$k});
	}
			
	# show results
	say qq[\nInput:  \@int = (] . join(q[, ], @int) . q[)];
	say qq[Output: (], substr($ordered, 0, -2) . ')';
	say substr($explain, 0, -1); 
}

sub make_sieve {

	my ($arg, $j, $k);
	
	# set all values provisionally to 1 (ie prime)
	$arg = shift;
	for $j (0 .. $arg) {
		$sieve[$j] = 1;
	}

	# for each prime in turn, set its multiples to 0 (ie not prime)
	for $j (2 .. $arg) {
		next unless $sieve[$j];   # $j is not prime
		last if $j ** 2 > $arg;
		for $k ($j .. $arg) {
			last if $k * $j > $arg;
			$sieve[$k * $j] = 0;
		}
	}
}

sub prime_factors {
	
	# returns count and list of prime factors
	
	my ($arg, $pf, $count, $list, $q, $prime);
	
	# initialise
	$arg = shift;
	$pf = '';
	$count = 0;
	$list = '';
	
	# loop over all primes <= input
	for $prime (2 .. $arg) {
		next unless $sieve[$prime];
		
		# try dividing remaining number repeatedly by each prime
		while (1) {
			$q = $arg / $prime;
			
			# found a prime factor - add to count and list
			if ($q == int($q)) {
				$count ++;
				$list .= qq[$prime, ];
				$arg = $q;
				
			# no more of this prime
			} else {
				last;
			}
		}
	}
	return ($count, substr($list, 0, -2));
}
	