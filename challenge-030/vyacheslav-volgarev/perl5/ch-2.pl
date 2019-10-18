#!/usr/bin/env perl

use strict;
use warnings;
use v5.10;
use List::Util qw( uniqstr );

my @numbers;

for my $first ( 1..10 ) {

	for my $second (1..10) {
		my $third = 12 - $first - $second;
		push @numbers, join ", ", sort { $a <=> $b } ( $first, $second, $third ) if $third > 0;
	}
}

$, = ";\n";
say uniqstr @numbers;
