#!/usr/bin/env perl

use strict;
use warnings;

sub challenge_185_2 {
	my (@codes) = @_;

	my $count = 4;
	my $mask = 'x';

	map { join 'x', split qr/[a-z0-9]/, $_, 4 +1 } @codes;
}

