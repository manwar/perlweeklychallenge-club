#!/usr/bin/perl

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';

use List::MoreUtils qw(frequency);
use List::Util qw(pairfirst);
use Math::Utils qw(floor);

sub majority_element {

	# As there can be at most one element with a frequency
	# above floor(size_of_list / 2), only the first matching
	# value/frequency-pair may have the result.
	(pairfirst {$b > floor(@_ / 2)} frequency @_)[0] // -1;
}

is majority_element(1, 2, 2, 3, 2, 4, 2), 2, 'first example';
is majority_element(1, 3, 1, 2, 4, 5), -1, 'second example';
is majority_element(1, 2, 2, 3, 2, 4, 2, 1), -1, 'even sized list';
is majority_element(0, 1, 0, 1, 0), 0, 'zero majority';

done_testing;
