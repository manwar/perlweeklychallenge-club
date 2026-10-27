#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    { in => [3,6,12],      out => [3,6,12]      },
    { in => [1,2,4,8],     out => [1,2,4,8]     },
    { in => [7,8,9,10],    out => [8,10,7,9]    },
    { in => [5,9,15,17],   out => [5,9,15,17]   },
    { in => [11,13,14,19], out => [14,13,11,19] },
);

is_deeply sort_binary_reflection(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub sort_binary_reflection {
    my $ref = sub { oct("0b" . reverse sprintf("%b", shift)) };
    return [ sort { $ref->($a) <=> $ref->($b) || $a <=> $b } @_ ];
}
