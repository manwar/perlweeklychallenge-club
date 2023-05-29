#! /usr/bin/raku

use Test;

plan 4;

is(maximumproduct([3, 1, 2]), 6, 'example 1');
is(maximumproduct([4, 1, 3, 2]), 24, 'example 2');
is(maximumproduct([-1, 0, 1, 3, 1]), 3, 'example 3');
is(maximumproduct([-8, 2, -9, 0, -4, 3]), 216, 'example 4');

sub maximumproduct(@lst) {
    my @l = sort {$^a <=> $^b}, @lst;
    my $b = @l.elems;
    my @t;
    for (0..3) -> $i {
        my $p = 1;
        if ($i > 0) {
            for (0..$i-1) -> $j {
                $p *= @l[$j];
            }
        }
        if ($i < 3) {
            for ($b-3+$i..$b-1) -> $j {
                $p *= @l[$j];
            }
        }
        @t.push($p);
    }
    return max(@t);
}
