#! /usr/bin/raku

use Test;

plan 3;

is(acronym(['Perl', 'Python', 'Pascal'], 'ppp'), True, 'example 1');
is(acronym(['Perl', 'Raku'], 'rp'), False, 'example 2');
is(acronym(['Oracle', 'Awk', 'C'], 'oac'), True, 'example 3');

sub acronym(@strs, $chk) {
    return @strs.map({substr($_, 0, 1)}).join("").lc eq $chk.lc;
}
