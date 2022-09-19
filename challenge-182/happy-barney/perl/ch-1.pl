#!/usr/bin/env perl

use strict;
use warnings;

sub challenge_182_1 {
	my ($list) = @_;

	return -1 unless @$list;

	my ($index, $max) = (0, $list->[0]);
	for my $element (1 .. $#$list) {
		($index, $max) = ($element, $list->[$element])
			if $max < $list->[$element];
	}

	return $index;
}

