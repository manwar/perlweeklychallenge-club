#!/usr/bin/env raku
use Test;

is-deeply good-integer(12344456),                ("444",);
is        good-integer(1233334),                 -1;
is-deeply good-integer(10020003),                ("000",);
is-deeply good-integer(77711233334445556678999), ("777", "444", "555", "999");

sub good-integer($int)
{
    my $m = $int ~~ m:ov/ (^ || \d) ( (\d) $0 $0 ) (\d || $) <?{ $1[0] !== $0|$2 }> /;
    return $m>>.[1]>>.Str || -1
}
