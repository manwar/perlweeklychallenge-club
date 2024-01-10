#! /usr/bin/raku

use Test;

plan 3;

is(luckynumbers([[3, 7, 9], [9, 11, 13], [15, 16, 17]]), 15, 'example 1');
is(luckynumbers([[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]), 12, 'example 2');
is(luckynumbers([[7, 8], [1, 2]]), 7, 'example 3');

sub luckynumbers(@a) {
    my $maxs = SetHash.new;
    for 0 .. @a[0].end() -> $x {
        my $max = [0, 0, 0];
        for 0 .. @a.end -> $y {
            if @a[$y][$x] > $max[0] {
                $max = [@a[$y][$x], $y, $x];
            }
        }
        $maxs{$max}++;
    }
    my $mins = SetHash.new;
    for 0 .. @a.end() -> $y {
        my $min = [@a[$y][0], $y, 0];
        for 0 .. @a[0].end -> $x {
            if @a[$y][$x] < $min[0] {
                $min = [@a[$y][$x], $y, $x];
            }
        }
        $mins{$min}++;
    }
    for $maxs.keys -> $i {
        for $mins.keys -> $j {
            if ($i[0] == $j[0] &&
                          $i[1] == $j[1] &&
                                    $i[2] == $j[2]) {
                return $i[0];
            }
        }
    }
    return -1;
}
