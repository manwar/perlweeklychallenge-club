#! /usr/bin/raku

use Test;

plan 5;

is(validtimes('?2:34'), 3, 'example 1');
is(validtimes('?4:?0'), 12, 'example 2');
is(validtimes('??:??'), 1440, 'example 3');
is(validtimes('?3:45'), 3, 'example 4');
is(validtimes('2?:15'), 4, 'example 5');

sub validtimes($a) {
    my @combinator;
    for $a.comb.kv -> $i, $c {
        if ($c ~~ /<[0..9]>/) {
            @combinator.push([0 + $c, ]);
        } else {
            if ($i == 0) {
                @combinator.push([0 .. 2]);
            } elsif ($i == 1 || $i == 4) {
                @combinator.push([0 .. 9]);
            } elsif ($i == 3) {
                @combinator.push([0 .. 5]);
            }
        }
    }
    if (@combinator.elems != 4) {
        return 0;
    }
    my $minutes = @combinator[2].elems * @combinator[3].elems;
    my $ct = 0;
    for @combinator[0].list -> $ax {
        for @combinator[1].list -> $bx {
            if ($ax * 10 + $bx <= 23) {
                $ct++;
            }
        }
    }
    $ct * $minutes;
}
