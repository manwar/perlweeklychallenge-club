#!/usr/bin/env perl

use strict;
use warnings;

sub compact {
	my @ns = split(/,/, shift);
	my $from = my $to = shift @ns; # The first interval is the first number
	my @intervals;

	# Store the current interval ($from, $to) and advance to the next one
	my $save = sub {
		push(@intervals, $from == $to ? $from : "$from-$to");
		$from = $to = shift;
	};

	# Iterate over the numbers, expanding the last interval or starting a new one
	foreach my $n (@ns) {
		if ($to == $n-1) {
			$to = $n;
		} else {
			&$save($n);
		}
	}

	# Store the last interval (except for empty input)
	&$save if defined $to;

	return join(",", @intervals);
}

foreach (@ARGV) {
	print compact($_), "\n";
}
