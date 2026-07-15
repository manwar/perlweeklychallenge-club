#!/usr/bin/env raku
use Test;

is-deeply rqm("01??0"), ("01000", "01010", "01100", "01110");
is-deeply rqm("101"), ("101",);
is-deeply rqm("???"), ("000", "001", "010", "011", "100", "101", "110", "111");
is-deeply rqm("1?10"), ("1010", "1110");
is-deeply rqm("1?1?0"), ("10100", "10110", "11100", "11110");

sub rqm($str)
{
    my @a = $str.comb("?");

    (^2**@a).map(
    {
        my @b = .fmt("%0" ~ @a.elems ~ "b").comb;
        $str.subst("?", {@b.shift}, :g)
    })
}
