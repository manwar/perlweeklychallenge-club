#! /usr/bin/perl6

use Test;

plan 2;

is(recomposemac("1ac2.34f0.b1c2"), "1a:c2:34:f0:b1:c2",
   'example 1');

is(recomposemac("abc1.20f1.345a"), "ab:c1:20:f1:34:5a",
   'example 2');

sub recomposemac($inp) {
    my $out = '';
    my $count = 0;
    for $inp.comb -> $c {
        if (($c ge '0' && $c le '9') || ($c ge 'a' && $c le 'f')) {
            if ($count == 2) {
                $out ~= ':';
                $count = 0;
            }
            $count++;
            $out ~= $c;
        }
    }
    return $out;
}
