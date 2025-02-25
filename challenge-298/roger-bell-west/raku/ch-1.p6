#! /usr/bin/raku

use Test;

plan 3;

is(maximalsquare([[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]), 4, 'example 1');
is(maximalsquare([[0, 1], [1, 0]]), 1, 'example 2');
is(maximalsquare([[0]]), 0, 'example 3');

sub maximalsquare(@a) {
    my $mx = 0;
    my $boundy = @a.elems;
    my $boundx = @a[0].elems;
    for 0 .. $boundy - 1 -> $y {
        for 0 .. $boundx - 1 -> $x {
            my $size = 0;
            while (True) {
                my @tests;
                for $x.. $x + $size -> $xx {
                    @tests.push([$y + $size, $xx]);
                }
                if ($size > 0) {
                    for $y .. $y + $size -> $yy {
                        @tests.push([$yy, $x + $size]);
                    }
                }
                if (@tests.map({@a[$_[0]][$_[1]]}).any == 0) {
                    last;
                }
                $size++;
                if ($x + $size >= $boundx || $y + $size >= $boundy) {
                    last;
                }
            }
            $mx = max($mx, $size * $size);
        }
    }
    $mx;
}
