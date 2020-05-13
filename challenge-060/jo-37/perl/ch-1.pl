#!/usr/bin/perl

# Input: column numbers (>=1) or column labels ([A-Z]+),
# output: column labels or column numbers
# Without arguments, converts some example values

# The numbering schema differs from the usual base(k) in the absence
# of a digit "zero".  I.e. there are digits for 1 .. k instead of
# 0 .. (k -1).  This results in the off-by-one modifications
# from the known formulae

use strict;
use warnings;
use bigint;
use constant BASE => 26;

sub int2label {
	my $int = $_[0] - 1;
	my @label;
	while ($int >= 0) {
		unshift @label, chr(ord('A') + $int % BASE);
		$int = $int / BASE - 1;
	}
	return join '', @label;
}

sub label2int {
	my @label = split '', $_[0];
	my $int = 0;
	for my $label (@label) {
		$int *= BASE;
		$int += ord($label) - ord('A') + 1;
	}
	return $int;
}

# last digit for BASE
my $last = chr(ord('A') + BASE - 1);

# build example input data if none provided
unless (@ARGV) {
	@ARGV = 
		map {((BASE**($_+1) - 1)/(BASE - 1) - 1, $last x $_)} (1 .. 14);
}

for (@ARGV) {
	if (/^\d+$/) {
		print "$_ -> ", int2label($_), "\n";
	} elsif (/^[A-$last]+$/) {
		print "$_ -> ", label2int($_), "\n";
	} else {
		print "input invalid: $_\n";
	}
}
