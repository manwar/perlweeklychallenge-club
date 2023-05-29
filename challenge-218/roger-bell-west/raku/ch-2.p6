#! /usr/bin/raku

use Test;

plan 2;

is(matrixscore([[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 1, 0]]), 39, 'example 1');
is(matrixscore([[0]]), 1, 'example 2');

sub matrixscore(@matrix0) {
    my @matrix = map {$_.Array}, @matrix0;
    for (0..@matrix.end) -> $i {
        if (@matrix[$i][0] == 0) {
            for (0..@matrix[0].end) -> $j {
                @matrix[$i][$j] = 1 - @matrix[$i][$j];
            }
        }
    }
    my $t = (@matrix.elems / 2).Int;
    for (1..@matrix[0].end) -> $i {
        my $c = 0;
        for (0..@matrix.end) -> $j {
            if (@matrix[$j][$i] == 0) {
                $c++;
            }
        }
        if ($c > $t) {
            for (0..@matrix.end) -> $j {
                @matrix[$j][$i] = 1 - @matrix[$j][$i];
            }
        }
    }
    my $tot = 0;
    for @matrix -> @m {
        my $p = 0;
        for @m -> $n {
            $p *= 2;
            if ($n == 1) {
                $p++;
            }
        }
        $tot += $p;
    }
    return $tot;
}
