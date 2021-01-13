#!/usr/bin/perl

use Test2::V0;
use List::Util 'product';

sub prod_arr {
	my $prod = product @_;
	die "invalid data" unless $prod;

	map $prod / $_, @_
}

is [prod_arr 5, 2, 1, 4, 3], [24, 60, 120, 30, 40], 'Example 1';
is [prod_arr 2, 1, 4, 3], [12, 24, 6, 8], 'Example 2';
like dies {prod_arr 2, 1, 0}, qr/^invalid data/,
	'zero is not a positive integer';
is [prod_arr 2, -5, 3], [-15, 6, -10], 'negative numbers are ok, though';

done_testing;
