#! /usr/bin/perl6

use Test;

plan 3;

is(firstunique("Perl Weekly Challenge"),0,'example 1');

is(firstunique("Long Live Perl"),1,'example 2');

is(firstunique("aabbcc"),-1,'example 3');

sub firstunique($s) {
    my @s = $s.comb;
    my %cc;
    map {%cc{$_}++}, @s;
    for 0..@s.end -> $i {
        if (%cc{@s[$i]} == 1) {
            return $i;
        }
    }
    return -1;
}
