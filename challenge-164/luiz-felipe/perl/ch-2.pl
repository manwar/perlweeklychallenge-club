#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

my ($counter, $number) = (0, 1);

while ($counter < 8) {
	if (is_happy($number)) {
		say $number;
		$counter++;
	}

	$number++;
}

sub happy_sum {
	my ($number, $sum);

	$number = shift;
	$sum = 0;

	foreach my $sub_number (split //, $number) {
		$sum += $sub_number ** 2;
	}

	return $sum;
}

sub is_happy {
	my ($number, %seen);

	$number = shift;

	until ($number == 1) {
		my $new_number = happy_sum($number);

		return if $seen{$new_number}++;

		$number = $new_number;
	}
}
