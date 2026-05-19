#!/usr/bin/env raku
use Test;

is same-digits-max("6777133339"), 3333;
is same-digits-max("1200034"),    4;
is same-digits-max("44221155"),   55;
is same-digits-max("88888"),      88888;
is same-digits-max("11122233"),   222;

sub same-digits-max($str)
{
    $str.comb(/(\d) $0*/).max(*.Int)
}
