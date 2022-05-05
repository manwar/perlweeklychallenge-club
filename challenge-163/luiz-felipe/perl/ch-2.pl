#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';

my (@numbers);

@numbers = @ARGV or die "you need to pass the numbers to the script";

say "The sum of these numbers is ", summations(@numbers);

sub summations {
	my (@numbers, $sum);

	@numbers = @_;

	while (scalar @numbers != 1) {
		my (@summations, $sum);

		$sum = 0;
		foreach my $i (1..$#numbers) {	
			$sum += $numbers[$i];
			push @summations, $sum;
		}

		@numbers = @summations;
	}

	return $numbers[0];
}
