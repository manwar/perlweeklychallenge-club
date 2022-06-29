#!/usr/bin/env perl

use v5.36;
use List::Util qw(sum0);

sub get_divisors ($number)
{
	return grep { $number % $_ == 0 } 1 .. $number / 2;
}

sub get_next_abundant_odd ($current = 1)
{
	while ('number is not abundant odd') {
		return $current
			if $current % 2 != 0
			&& sum0(get_divisors $current) > $current
		;

		++$current;
	}
}

my $current = 0;
for (1 .. 20) {
	$current = get_next_abundant_odd($current + 1);
	say $current;
}

