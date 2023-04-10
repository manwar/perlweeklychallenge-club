#!/usr/bin/env raku

use v6.d;

sub get-indices(Int $ystart, Int $ymax, Int $xstart, Int $xmax --> List) {
    my Int $count-indices = min($xmax - $xstart, $ymax - $ystart);
    return (($xstart, $ystart), { $_[0] + 1, $_[1] + 1 } … *)[^$count-indices];
}

sub check-indices(@a, @indices --> Bool) {
    my Int $val = @a[@indices[0][1]][@indices[0][0]];
    so $val == map({ @a[$_[1]][$_[0]] }, @indices).all;
}

sub toeplitz-rows(@matrix, Int $xmax, Int $ymax --> Bool) {
    my @y-indices = map({ get-indices($_, $ymax, 0, $xmax) }, 1 ..^ $ymax);
    return so map({ check-indices(@matrix, $_) }, @y-indices).all;
}

sub toeplitz-columns(@matrix, Int $xmax, Int $ymax  --> Bool) {
    my @x-indices = map({ get-indices(0, $ymax, $_, $xmax) }, 0 ..^ $xmax);
    return so map({ check-indices(@matrix, $_) }, @x-indices).all;
}

sub is-toeplitz(@matrix --> Bool) {
    my Int $xmax = @matrix[0].elems;
    my Int $ymax = @matrix.elems;
    # return toeplitz-columns(@matrix, $xmax, $ymax) and toeplitz-rows(@matrix, $xmax, $ymax);
    return so map({ $_(@matrix, $xmax, $ymax) }, (&toeplitz-columns, &toeplitz-rows)).all;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    my @a = [
        [4, 3, 2, 1],
        [5, 4, 3, 2],
        [6, 5, 4, 3]
    ];

    my @b = [
        [1, 2, 3],
        [3, 2, 1]
    ];

    is is-toeplitz(@a), True, "works for @a";
    is is-toeplitz(@b), False, "works for @b";
}
