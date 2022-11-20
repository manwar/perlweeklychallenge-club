#! /usr/bin/perl6

use Test;

plan 3;

is(cutelist(2), 2, 'example 1');
is(cutelist(10), 700, 'example 2');
is(cutelist(15), 24679, 'example 3');

sub cutelist($n) {
    my @tab = ([]);
    for (1..$n) {
        @tab.push([False xx ($n+1)]);
    }
    for (1..$n) -> $x {
        for (1..$x) -> $y {
            if ($x % $y != 0 && $y % $x != 0) {
                @tab[$x][$y] = @tab[$y][$x] = True;
            }
        }
    }
    my $count = 0;
    my @stackl = [[],];
    my @stackc = [[1..$n],];
    while (@stackl.elems > 0) {
        my @l = @stackl.pop.flat;
        my @c = @stackc.pop.flat;
        if (@c.elems == 0 && @l.elems == $n) {
            $count++;
        } else {
            my $place = @l.elems + 1;
            for @c -> $candidate {
                unless (@tab[$place][$candidate]) {
                    my @q = @l.clone;
                    @q.push($candidate);
                    @stackl.push(@q);
                    my @qc = @c.grep({$_ != $candidate});
                    @stackc.push(@qc);
                }
            }
        }
    }
    return $count;
}
