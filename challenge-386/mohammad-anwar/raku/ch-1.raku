#!/usr/bin/env raku

use Test;

my @examples = (
    { in => ["101010",  2], out => 42        },
    { in => ["EEADEE", 16], out => 15642094  },
    { in => ["755",     8], out => 493       },
    { in => ["1BRJB",  36], out => 2228519   },
    { in => ["7MyqL",  64], out => 123456789 },
);

is base-to-int(|$_{<in>}), $_{<out>} for @examples;

done-testing;

sub base-to-int ($num, $base) {
    state $chars = ("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/".comb Z=> 0..63).Hash;

    my $val = 0;
    $val = $val * $base + $chars{$_} for $num.comb;
    return $val;
}
