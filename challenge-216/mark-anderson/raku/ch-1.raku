#!/usr/bin/env raku
use Test;

is-deeply reg-num(<abc abcd bcd>,    "AB1 2CD"), ("abcd",);
is-deeply reg-num(<job james bjorg>, "007 JB"),  <job bjorg>;
is-deeply reg-num(<crack road rac>,  "C7 RA2"),  <crack rac>;  

sub reg-num($words, $reg)
{
    my $r = $reg.comb(/<upper>/)>>.lc;
    $words.Slip.grep({ .comb (>=) $r })
}
