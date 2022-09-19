#!/usr/bin/perl

# Peter Campbell Smith - 2022-07-07
# PWC 171 task 1

use v5.28;
use strict;
use warnings;
use utf8;
binmode(STDOUT, ':utf8');

# You are given two positive integers, $m and $n.
# Write a script to find out the Prime Partition of the given number. No duplicates allowed.

# I assume (from the examples) this means $n distinct prime numbers which sum to $m.

# Blog: https://pjcs-pwc.blogspot.com/2022/07/tricky-partitions-and-easy-stats.html

my (@tests, @is_prime, $test, $m, $n, @is_used, @parts, $or, $output, $start);

@tests = ([18, 2], [19, 3], [501, 4]);
@is_prime = make_sieve(1000);   # $sieve[$j] == 1 if $j is prime
$is_prime[1] = 0;               # examples suggest that 1 is not allowed as a prime

# loop over tests
for $test (@tests) {
	($m, $n) = @$test;
	say qq[\nInput:  \$m = $m, \$n = $n];
	
	# initialise
	@is_used = ();   # we are looking for distinct primes, so set $is_used[$j] if $j is already used
	@parts = ();     # these are the components of the set of primes
	$or = '';
	$output = 'Output: ';
	$start = $m;     # the largest possible number that fits in the initial gap
	
	# find the answer
	fill_gap($m, $n);
	say $output;
}
		
sub fill_gap {  # 

	# fill_gap($gap, $count) finds all the sets of $count distinct primes which add up to $gap

	my ($gap, $count, $j, $result, $new_gap);
	$gap = shift;
	$count = shift;
	
	# loop downwards over primes from the last one tried
	for ($j = $start; $j >= 1; $j --) {
		next if (not $is_prime[$j] or $is_used[$j]);
		
		# let's assume this is the right one
		$parts[$n - $count] = $j;
		
		# ... and it would reduce the gap to $new_gap
		$new_gap = $gap - $j;
		
		# if $new gap is zero and $count == 1 then we have a result
		if ($new_gap == 0 and $count == 1) {
			$output .= $or . join(', ', reverse @parts);  # Mohammad wants them in increasing order
			$or = ' or ';
			
		# or if $count is > 1 we call fill_gap recursively to fill $new_gap with $count - 1 primes	
		} elsif ($count != 1) {
			$is_used[$j] = 1;
			$start = $j;
			fill_gap($new_gap, $count - 1);
			$is_used[$j] = 0;
			
		# or if $count == 0 but this prime won't fill the gap then we keep on trying
		} else {
			$is_used[$j] = 0;
		}
	}
	$parts[$n - $count] = 0;
}

sub make_sieve {
	
	# make sieve of Eratosthenes - $j is prime if $sieve[$j];
	my ($arg, $j, $k, @sieve);
	
	# set all values provisionally to 1 (ie prime)
	$arg = $_[0];
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
	return @sieve;
}