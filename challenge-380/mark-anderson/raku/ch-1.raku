#!/usr/bin/env raku
use Test;

is sum-of-freq("banana"),   5;
is sum-of-freq("teestett"), 7;
is sum-of-freq("aeiouuaa"), 3;
is sum-of-freq("rhythm"),   2;
is sum-of-freq("x"),        1;

sub sum-of-freq($str)
{
    my %c = $str.comb.classify(* ~~ any(<a e i o u>));
    %c.values>>.Bag>>.max(:by(*.value))>>.value.sum
}
