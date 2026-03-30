#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    [ "1011",   "1101"   ],
    [ "100",    "001"    ],
    [ "111000", "110001" ],
    [ "0101",   "1001"   ],
    [ "1111",   "1111"   ],
);

is max_odd_binary($_->[0]), $_->[1] foreach @examples;

done_testing;

sub max_odd_binary {
    my $str = shift;
    my $c1  = $str =~ tr/1//;
    my $c0  = $str =~ tr/0//;

    return "1" x ($c1 - 1) . "0" x $c0 . "1";
}
