#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

for my $number (0..1000) {
	say $number if is_palindrome($number) and is_prime($number);
}

sub is_palindrome {
	my (@number, $reverse);

	@number = split //, shift;
	$reverse = "";

	for (my $i = $#number; $i >= 0; $i--) {
		$reverse = $reverse . $number[$i];
	}

	return $reverse eq join '', @number;
}

sub is_prime {
	my ($number);

	$number = shift;

	return 0 if $number == 0 or $number == 1;

	for (my $i = 2; $i <= $number / 2; $i++) {
		return 0 if ($number % $i == 0);
	}

	return 1;
}
