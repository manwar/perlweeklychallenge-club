#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => ["101010",  2], out => 42        },
    { in => ["EEADEE", 16], out => 15642094  },
    { in => ["755",     8], out => 493       },
    { in => ["1BRJB",  36], out => 2228519   },
    { in => ["7MyqL",  64], out => 123456789 },
);

is base_to_int(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub base_to_int ($num, $base) {
    state $chars = { map {
        substr("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/", $_, 1) => $_
        } 0 .. 63
    };

    my $val = 0;
    $val = $val * $base + $chars->{$_} for split //, $num;
    return $val;
}
