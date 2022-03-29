#! /usr/bin/perl6

use Test;

plan 3;

is(brazilian(7),
   True,
   'example 1');

is(brazilian(6),
   False,
   'example 2');

is(brazilian(8),
   True,
   'example 3');

sub brazilian($n) {
    for (2..$n-2) -> $b {
        my $nn = $n;
        my $braz = True;
        my $digit = $nn % $b;
        while ($nn > 0) {
            if ($digit == $nn % $b) {
                $nn div= $b;
            } else {
                $braz = False;
                last;
            }
        }
        if ($braz) {
            return True;
        }
    }
    return False;
}
