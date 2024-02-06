#! /usr/bin/raku

use Test;

plan 3;

is(threepower(27), True, 'example 1');
is(threepower(0), False, 'example 2');
is(threepower(6), False, 'example 3');

sub threepower($n0) {
    if ($n0 == 0) {
        return False;
    }
    my $n = abs($n0);
    my $lo = 1;
    my Int $hi = $n div 2;
    while (True) {
        my Int $t = ($lo + $hi) div 2;
        my $c = $t * $t * $t;
        if ($c == $n) {
            return True;
        }
        if ($lo == $t) {
            return False;
        }
        if ($c < $n) {
            $lo = $t;
        } else {
            $hi = $t;
        }
    }
}
