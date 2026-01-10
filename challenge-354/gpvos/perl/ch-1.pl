#!/usr/bin/perl -w

use strict;
use feature 'say';
use Test::More tests => 8;
use List::Util qw(min);
use List::MoreUtils qw(slide indexes);

sub minimum_absolute_difference_pairs {
	my(@ints) = sort { $a <=> $b } $_[0]->@*;
	# Make sure to handle empty and 1-element arrays correctly.
	my(@diffs) = @ints > 1 ? slide { $b - $a } @ints : ();
	my $min = min @diffs;
	return [ map { [ $ints[$_], $ints[$_ + 1] ] }
		indexes { $_ == $min } @diffs ];
}

is_deeply(minimum_absolute_difference_pairs([ ]), [ ], "Empty array");
is_deeply(minimum_absolute_difference_pairs([ 99 ]), [ ], "1-element array");
is_deeply(minimum_absolute_difference_pairs([ -1, 9 ]),
	[ [ -1, 9 ] ],
	"2-element array");
is_deeply(minimum_absolute_difference_pairs([ 4, 2, 1, 3 ]),
	[ [1, 2], [2, 3], [3, 4] ],
	"Example 1");
is_deeply(minimum_absolute_difference_pairs([ 10, 100, 20, 30 ]),
	[ [10, 20], [20, 30] ],
	"Example 2");
is_deeply(minimum_absolute_difference_pairs([ -5, -2, 0, 3 ]),
	[ [-2, 0] ],
	"Example 3");
is_deeply(minimum_absolute_difference_pairs([ 8, 1, 15, 3 ]),
	[ [1, 3] ],
	"Example 4");
is_deeply(minimum_absolute_difference_pairs([ 12, 5, 9, 1, 15 ]),
	[ [9, 12], [12, 15] ],
	"Example 5");
done_testing;

