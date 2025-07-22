#! /usr/bin/raku

use Test;

plan 3;

is(lastword('The Weekly Challenge'), 9, 'example 1');
is(lastword('   Hello   World    '), 5, 'example 2');
is(lastword("Let's begin the fun"), 3, 'example 3');

sub lastword($a) {
    my @w = $a.split(' ').grep({$_.chars > 0});
    @w[*-1].chars;
}
