#!/bin/env perl6

use Test;
plan 24;

dec-vs-rom(39, 'XXXIX');

dec-vs-rom(160, 'CLX');
dec-vs-rom(207, 'CCVII');
dec-vs-rom(246, 'CCXLVI');
dec-vs-rom(789, 'DCCLXXXIX');

dec-vs-rom(1009, 'MIX');
dec-vs-rom(1066, 'MLXVI');
dec-vs-rom(1776, 'MDCCLXXVI');
dec-vs-rom(1954, 'MCMLIV');
dec-vs-rom(2014, 'MMXIV');
dec-vs-rom(2019, 'MMXIX');
dec-vs-rom(2421, 'MMCDXXI');

sub dec-vs-rom(Int $n, Str $s) {
    my $script = './01.p6';

    my $res = run $script, $n, :out;
    is $res.out.get, $s, "$n => $s";

    $res = run $script, $s, :out;
    is $res.out.get, $n, "$s => $n";
}
