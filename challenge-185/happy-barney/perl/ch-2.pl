#!/usr/bin/env perl

use strict;
use warnings;

sub challenge_185_2 {
	my (@codes) = @_;

	my $count = 4;
	my $mask = 'x';

	for my $code (@codes) {
		$code =~ s/^ ((?: $mask \W*){$_}) [a-z0-9]/$1$mask/x
			for 0 .. $count - 1;
	}

	return @codes;
}

