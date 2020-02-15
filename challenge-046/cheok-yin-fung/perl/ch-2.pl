#!/usr/bin/perl
use strict;
use integer;

my @doors;
my $labor;

$doors[0] = 'true'; # main entrance

for my $i (1..500) {
	$doors[$i] = undef;
}

for my $i (1..250) {
	$labor = int(500/$i);
	for my $j (1..$labor) {
		$doors[$i*$j] = not($doors[$i*$j]);
	}
}

for my $i (251..500) {
	$doors[$i] = not($doors[$i]);
}

for my $i (1..500) {
	if ($doors[$i]) {print $i, "\n";}
}


