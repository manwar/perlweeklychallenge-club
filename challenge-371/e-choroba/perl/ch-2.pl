#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };

sub subset_equilibrium(@nums) {
    my @results;
    for my $indicator (1 .. 2 ** @nums - 2) {
        my $bin = sprintf '%b', reverse $indicator;
        my @indices = map length($bin) - 1 - $_,
                      grep 1 eq substr($bin, $_, 1),
                      0 .. length($bin) - 1;
        next if 1 == @indices;

        push @results, [@nums[@indices]]
            if sum0(@indices, scalar @indices) == sum0(@nums[@indices]);
    }
    return @results
}

use Test2::V0;
plan(5);

is [subset_equilibrium(2, 1, 4, 3)],
    bag {
        item bag { item 2; item 1; end };
        item bag { item 1; item 4; end };
        item bag { item 4; item 3; end };
        item bag { item 2; item 3; end };
        end
    }, 'Example 1';

is [subset_equilibrium(3, 0, 3, 0)],
    bag {
        item bag { item 3; item 0; end };
        item bag { item 3; item 0; item 3; end };
        end
    }, 'Example 2';

is [subset_equilibrium(5, 1, 1, 1)],
    [bag { item 5; item 1; item 1; end }], 'Example 3';

is [subset_equilibrium(3, -1, 4, 2)],
    bag {
        item bag { item 3; item 2; end };
        item bag { item 3; item -1; item 4; end };
        end
}, 'Example 4';

is [subset_equilibrium(10, 20, 30, 40)], [], 'Example 5';
