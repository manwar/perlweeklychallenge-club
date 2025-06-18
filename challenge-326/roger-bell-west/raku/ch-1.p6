#! /usr/bin/raku

use Test;

plan 3;

is(dayoftheyear('2025-02-02'), 33, 'example 1');
is(dayoftheyear('2025-04-10'), 100, 'example 2');
is(dayoftheyear('2025-09-07'), 250, 'example 3');

sub parsedate($s) {
    $s ~~ /(<[0..9]>+)\D(<[0..9]>+)\D(<[0..9]>+)/;
    return Date.new($0, $1, $2);
}

sub dayoftheyear($a) {
    my $d1 = Date.new($a);
    my $d0 = Date.new($d1.year, 1, 1);
    $d1.daycount - $d0.daycount + 1;
}
