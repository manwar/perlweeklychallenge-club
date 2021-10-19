#!/usr/bin/env perl

# TASK #2 > Smith Numbers
# Submitted by: Mohammad S Anwar
# Write a script to generate first 10 Smith Numbers in base 10.
# 
# According to Wikipedia:
# 
# In number theory, a Smith number is a composite number for which, in a given
# number base, the sum of its digits is equal to the sum of the digits in its 
# prime factorization in the given number base.
# 

use Modern::Perl;
use ntheory 'factor', 'is_prime';
use List::Util 'sum';

my $n = 1;
my $count = 0;
while ($count < 10) {
	$n++;
	if (is_smith($n)) {
		say $n;
		$count++
	}
}

sub is_smith {
	my($n) = @_;
	return if is_prime($n);
	my @digits = split //, $n;
	my $sum1 = sum(@digits);
	my @fact_digits = split //, join '', factor($n);
	my $sum2 = sum(@fact_digits);
	return $sum1 == $sum2;
}
