#!/usr/bin/perl -w

use v5.34;
use strict;

# As you see, I like to not keep more data around than strictly necessary.
# Rewriting this to actually read input from an array is trivial.
# Note that, as my teacher said: the empty array is also an array.

my($tot, $numtot, $min, $nummin, $max, $nummax);
while (defined(my $i = <>)) { # foreach my $i (@array) {
	++$numtot;
	$tot += $i;
	($min = $i, $nummin = 0) if !defined $min or $i < $min;
	++$nummin if $i == $min;
	($max = $i, $nummax = 0) if !defined $max or $i > $max;
	++$nummax if $i == $max;
}

#say "$numtot:$tot:$nummin:$min:$nummax:$max";

if (defined $min) { # also means defined $max
	$numtot -= $nummin;
	$tot -= $nummin * $min;
	if ($min != $max) {
		$numtot -= $nummax;
		$tot -= $nummax * $max;
	}
}

#say "$numtot:$tot";
say (($numtot // 0) > 0 ? $tot / $numtot : 0);

