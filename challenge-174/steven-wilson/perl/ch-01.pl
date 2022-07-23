#!/usr/bin/env perl
# Week 174 Task 1
# Disarium Numbers
# Write a script to generate first 19 Disarium Numbers

use strict;
use warnings;
use feature qw/ say /;

my $number = 0;
my @disarium_numbers;

while ( scalar @disarium_numbers < 19) {
	if (disarium($number)) {
		push @disarium_numbers, $number;
	}
	$number++;
}

say join " ", @disarium_numbers;

sub disarium {
	my $number = shift;
	my @numbers = split //, $number;
	my $sum = 0;
	my $i = 1;
	for ($i .. scalar @numbers) {
		$sum += ($numbers[$_ - 1] ** $_);
	}
	return $sum == $number;
}
