#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(eban(100),[2, 4, 6, 30, 32, 34, 36, 40, 42, 44, 46, 50, 52, 54, 56, 60, 62, 64, 66],
          'example 1');

sub eban($mx) {
    my @units=(True,False,True,False,True,False,True,False,False,False);
    my @tens=(True,False,False,True,True,True,True,False,False,False,False);
    my @out;
    for (0..$mx) -> $i {
        if (@tens[floor($i/10)] && @units[$i % 10] && $i != 0) {
            push @out,$i;
        }
    }
    return @out;
}
