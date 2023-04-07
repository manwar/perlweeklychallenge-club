#!/usr//bin/perl
# Example 1
# 
# Input: @matrix = [ [4, 3, 2, 1],
#                    [5, 4, 3, 2],
#                    [6, 5, 4, 3],
#                  ]
# Output: true
# 
# Example 2
# 
# Input: @matrix = [ [1, 2, 3],
#                    [3, 2, 1],
#                  ]
# Output: false

use strict;
use warnings;
use Test::More;

my $cases = [
	[[4, 3, 2, 1],
	 [5, 4, 3, 2],
	 [6, 5, 4, 3],
	],
	[[1, 2, 3],
	 [3, 2, 1],
	],
];

sub is_toeplitz
{
	my $mref = shift;

    my $m = $mref->@* - 1;
    my $n = $mref->[0]->@* - 1;
    for(my $i=0; $i < $m; ++$i) {
		for(my $j=0; $j < $n; ++$j) {
			return 0 if ($mref->[$i]->[$j] != $mref->[$i + 1][$j + 1]);
		}
	}

	return 1;
}

is(is_toeplitz($cases->[0]), 1, 'Toeplitz');
is(is_toeplitz($cases->[1]), 0, 'Non-Toeplitz');
done_testing();

exit 0;

