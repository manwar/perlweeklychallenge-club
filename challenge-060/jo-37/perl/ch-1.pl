#!/usr/bin/perl

# Input: column number (>=1), output: excel column name
# Input: excel column name ([A-Z]+), output: column number

use strict;
use warnings;
use bigint;

sub dectoxls {
	my $dec = $_[0] - 1;
	my @b26;
	while ($dec >= 0) {
		unshift @b26, chr(ord('A') + $dec % 26);
		$dec = $dec / 26 - 1;
	}
	return join '', @b26;
}

sub xlstodec {
	my @b26 = split '', $_[0];
	my $dec = 0;
	for my $b26 (@b26) {
		$dec *= 26;
		$dec += ord($b26) - ord('A') + 1;
	}
	return $dec;
}

for ($ARGV[0]) {
	if (/^\d+$/) {
		print dectoxls($_), "\n";
	} elsif (/^[A-Z]+$/) {
		print xlstodec($_), "\n";
	} else {
		print "input invalid: $_\n";
	}
}
