#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => 20,    out => 2   },
    { in => 110,   out => 4   },
    { in => 500,   out => 11  },
    { in => 2026,  out => 105 },
    { in => 10000, out => 105 },
);

is max_jump($_->{in}), $_->{out} foreach @examples;

done_testing;

sub max_jump($num) {
    my @nums     = grep !/(\d).*\1/, 1 .. $num;
    my $max_diff = 0;

    for my $i (1 .. $#nums) {
        my $diff  = $nums[$i] - $nums[$i - 1];
        $max_diff = $diff if $diff > $max_diff;
    }

    return $max_diff;
}
