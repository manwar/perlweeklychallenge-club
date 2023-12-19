#! /usr/bin/raku

use Test;

plan 2;

is-deeply(submatrixsum([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]), [[14, 18, 22], [30, 34, 38]], 'example 1');
is-deeply(submatrixsum([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]), [[2, 1, 0], [1, 2, 1], [0, 1, 2]], 'example 2');

sub submatrixsum(@a) {
    my @out;
    for (0 .. @a.end - 1) -> $y {
        my @row;
        for (0 .. @a[$y].end - 1) -> $x {
            my $s = 0;
            for ($y .. $y + 1) -> $ya {
                for ($x .. $x + 1) -> $xa {
                    $s += @a[$ya][$xa];
                }
            }
            @row.push($s);
        }
        @out.push(@row)
    }
    return @out;
}
