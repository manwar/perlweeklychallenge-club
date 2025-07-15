#! /usr/bin/raku

use Test;

plan 3;

is(cleardigits('cab12'), 'c', 'example 1');
is(cleardigits('xy99'), '', 'example 2');
is(cleardigits('pa1erl'), 'perl', 'example 3');

sub cleardigits($a) {
    my @out;
    for $a.comb -> $c {
        if ($c ~~ /\d/) {
            @out.pop;
        } else {
            @out.push($c);
        }
    }
    @out.join('');
}
