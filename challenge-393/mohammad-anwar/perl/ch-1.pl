#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => 20, out => 12 },
    { in => 7,  out => 2  },
    { in => 1,  out => 0  },
    { in => 15, out => 8  },
    { in => 30, out => 22 },
);

is count_pythagorean_triplets($_->{in}), $_->{out} foreach @examples;

done_testing;

sub count_pythagorean_triplets($n) {
    my $count = 0;
    for my $a (1 .. $n) {
        for my $b (1 .. $n) {
            my $c = sqrt($a*$a + $b*$b);
            $count++ if $c <= $n && $c == int($c);
        }
    }
    return $count;
}
