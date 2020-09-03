#!/usr/bin/perl

use Test2::V0;
use Math::Prime::XS 'is_prime';
use bigint;

# The task states:
#	"find the minimum number of prime numbers required, whose summation
# 	gives you $N".
# This does not imply finding specific summands, IMHO.
#
# According to Goldbach's conjecture, every even number greater than two
# can be expressed as the sum of two primes.  As there is no exception to
# this rule for $n <= 4e18, it may be considered as valid for this task.
sub num_prime_summands {
	my ($n) = @_;					# keep @_
	$_[1] = 2;						# provide default retcode

	return 0 if $n < 2;				# not a sum of primes
	return 1 if $n == 2;			# 2 is prime
	goto &assure if $n % 2 == 0;	# Goldbach's conjecture
	return 1 if is_prime $n;		# $n is prime
	return 2 if is_prime $n - 2;	# $n - 2 is prime

	$_[1]++; goto &assure;			# Else: $n minus any odd prime is even,
									# where Goldbach's conjecture is
									# applied again.
}

# Warn about results that cannot be assured.
sub assure {
	my ($n, $r) = @_;
	warn "The result is not assured!\n" if $n > 4e18;

	$r;
}


is num_prime_summands($_->[0]), $_->[1]
	foreach [1, 0], [2, 1], [3, 1], [4, 2], [5, 1], [6, 2], [7, 1],
		[8, 2], [9, 2], [10, 2], [11, 1], [12, 2], [13, 1], [14, 2],
		[15, 2], [16, 2], [17, 1], [18, 2], [19, 1], [20, 2], [21, 2],
		[22, 2], [23, 1], [24, 2], [25, 2], [26, 2], [27, 3], [28, 2];

done_testing;
