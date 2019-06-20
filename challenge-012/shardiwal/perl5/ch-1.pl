#!/usr/bin/perl

use warnings;
use strict;
use feature qw(say);

# The numbers formed by adding one to the products of the smallest primes are
# called the Euclid Numbers (see wiki). Write a script that finds the smallest
# Euclid Number that is not prime. This challenge was proposed by Laurent
# Rosenfeld.

say scan_not_prime_euclid_number();

sub scan_not_prime_euclid_number {
	my $number = 1;
	my $eucid_number;
	while ( not $eucid_number ) {
		$eucid_number = get_euclid_number($number);
		$number++;
	}
	return $eucid_number;
}

sub get_euclid_number {
	my $num = shift;
	my $product = prime_product($num);
	my $eucid_number = $product + 1;
	return if is_prime($eucid_number);
	# Euclid Number that is not prime.
	return $eucid_number;
}

sub prime_product {
	my $num     = shift;
	my $product = 1;
	map { $product *= $_ if is_prime($_); } ( 1 .. $num );
	return $product;
}

sub is_prime {
	my $number   = shift;
	return 0 if grep { $number % $_ == 0 } ( 2 .. sqrt($number) );
	return 1;
}
