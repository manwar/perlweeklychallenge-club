#!/usr/bin/perl -w

use strict;
use feature 'say';
use Test::More tests => 5;
use List::Util qw(reductions);

sub binary_prefixes_divisible_by_5 {
	return map { $_ % 5 ? 'false' : 'true' }
		binary_prefixes(@_);
}

sub binary_prefixes {
	return map { eval('0b' . $_) }
		reductions { $a . $b } @_;
}

is_deeply([ binary_prefixes_divisible_by_5(0, 1, 1, 0, 0, 1, 0, 1, 1, 1) ],
	[ 'true', 'false', 'false', 'false', 'false', 'true', 'true', 'false', 'false', 'false' ],
	"Example 1");
is_deeply([ binary_prefixes_divisible_by_5(1, 0, 1, 0, 1, 0) ],
	[ 'false', 'false', 'true', 'true', 'false', 'false' ],
	"Example 2");
is_deeply([ binary_prefixes_divisible_by_5(0, 0, 1, 0, 1) ],
	[ 'true', 'true', 'false', 'false', 'true' ],
	"Example 3");
is_deeply([ binary_prefixes_divisible_by_5(1, 1, 1, 1, 1) ],
	[ 'false', 'false', 'false', 'true', 'false' ],
	"Example 4");
is_deeply([ binary_prefixes_divisible_by_5(1, 0, 1, 1, 0, 1, 0, 0, 1, 1) ],
	[ 'false', 'false', 'true', 'false', 'false', 'true', 'true', 'true', 'false', 'false' ],
	"Example 5");
done_testing();

