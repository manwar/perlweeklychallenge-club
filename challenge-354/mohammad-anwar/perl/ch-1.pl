#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => [4, 2, 1, 3],      out => [[1, 2], [2, 3], [3, 4]] },
    { in => [10, 100, 20, 30], out => [[10, 20], [20, 30]]     },
    { in => [-5, -2, 0, 3],    out => [[-2, 0]]                },
    { in => [8, 1, 15, 3],     out => [[1, 3]]                 },
    { in => [12, 5, 9, 1, 15], out => [[9, 12], [12, 15]]      },
);

is_deeply min_abs_diff($_->{in}), $_->{out} for @examples;

done_testing;

sub min_abs_diff {
    my @ints = @{ $_[0] };

    my @a = sort { $a <=> $b } @ints;
    my $m = 9**9;
    for (0 .. $#a - 1) {
        ($a[$_+1] - $a[$_]) < $m && ($m = $a[$_+1] - $a[$_]);
    }

    [
        map  { [ $a[$_], $a[$_+1] ]    }
        grep { $a[$_+1] - $a[$_] == $m }
        0 .. $#a - 1
    ];
}
