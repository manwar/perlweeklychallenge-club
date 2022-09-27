#!/usr/bin/env perl

use strict;
use warnings;

sub challenge_184_1 {
	my (@strings) = @_;

	my $sequence = "00";
	substr ($_, 0, 2) = $sequence ++
		for @strings;

	return @strings;
}

