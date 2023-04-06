#!/usr//bin/perl
# Example 1:
# 
# Input: @list = (2, 3, -1)
# Output: (2, 3)
# 
# The numbers 3 and -1 collide and -1 explodes in the end. So we are left with (2, 3).
# 
# Example 2:
# 
# Input: @list = (3, 2, -4)
# Output: (-4)
# 
# The numbers 2 and -4 collide and 2 explodes in the end. That gives us (3, -4).
# Now the numbers 3 and -4 collide and 3 explodes. Finally we are left with -4.
# 
# Example 3:
# 
# Input: @list = (1, -1)
# Output: ()
# 
# The numbers 1 and -1 both collide and explode. Nothing left in the end.

use strict;
use warnings;
use Test::More;

my $cases = [
	[2, 3, -1],
	[3, 2, -4],
	[1, -1],
];

sub collision
{
    my @a = (shift)->@*;
	my $coll;
	do {
		$coll = 0;
		for my $i (0 .. ($#a-1)) {
			my ($x, $y) = ($a[$i], $a[$i+1]);
			my $xa = abs($x);
			my $ya = abs($y);
			if (($x < 0 and $y > 0) or ($x > 0 and $y < 0)) { # collision
				++$coll;
				if ($xa == $ya) {
					splice(@a, $i, 2);
				} elsif  ($xa < $ya) {
					splice(@a, $i, 1);
				} elsif  ($xa > $ya) {
					splice(@a, $i+1, 1);
				}
			}
		}
	} while $coll;
	return '(' . join(', ', @a) . ')';
}

is(collision($cases->[0]), '(2, 3)', '[2, 3, -1]');
is(collision($cases->[1]), '(-4)',   '[3, 2, -4]');
is(collision($cases->[2]), '()',     '[1, -1]');
done_testing();

exit 0;

