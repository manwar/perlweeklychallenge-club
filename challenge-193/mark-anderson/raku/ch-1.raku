#!/usr/bin/env raku
use Test;

is-deeply binary-string(2), ('00', '01', '10', '11');
is-deeply binary-string(3), ('000', '001', '010', '011', '100', '101', '110', '111');

sub binary-string($n)
{
    map { .fmt: "\%0{$n}b" }, ^2**$n
}
