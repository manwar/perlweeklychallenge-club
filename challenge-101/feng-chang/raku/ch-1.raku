#!/bin/env raku

sub get-tight-mn(UInt:D \size --> List:D) {
    (1..size X 1..size).grep({ .[0] ≤ .[1] and .[0] * .[1] == size}).min({ .[1] - .[0] });
}

sub tighten(*@A) {
    my UInt ($h, $w) = get-tight-mn(@A.elems);
    my @R;
    @R[^$h;^$w] = '.' xx ∞;
    my UInt ($y, $x) = ($h - 1, 0);
    while @A.elems > 0 {
        @R[$y;$x++] = $_ for @A.splice(0, $w);

        --$x;
        --$h;
        last unless $h > 0;
        @R[--$y;$x] = $_ for @A.splice(0, $h);

        --$w;
        last unless $w > 0;
        @R[$y;--$x] = $_ for @A.splice(0, $w);

        --$h;
        last unless $h > 0;
        @R[++$y;$x] = $_ for @A.splice(0, $h);

        ++$x;
        --$w;
    }

    @R;
}

sub show(*@A) {
    my $width = @A[*;*]».chars.max;
    put @A[$_]».fmt("%{ $width }s").join(' ') for ^@A.elems;
}

multi MAIN('test') {
    use Test;

    is-deeply get-tight-mn(6),  (2, 3), 'get-tight-mn(6)  => 2, 3';
    is-deeply get-tight-mn(5),  (1, 5), 'get-tight-mn(5)  => 1, 5';
    is-deeply get-tight-mn(9),  (3, 3), 'get-tight-mn(9)  => 3, 3';
    is-deeply get-tight-mn(24), (4, 6), 'get-tight-mn(24) => 4, 6';

    is-deeply tighten(1, 2, 3), [[1, 2, 3],], 'tighten(1..3) is correct';
    is-deeply tighten(1..4), [[4, 3], [1, 2]], 'tighten(1..4) is correct';
    is-deeply tighten(1..9), [[7, 6, 5], [8, 9, 4], [1, 2, 3]], 'tighten(1..9) is correct';

    done-testing;
}

multi MAIN(UInt:D \n) {
    show tighten(1..n);
}

multi MAIN(*@A) {
    show tighten(@A);
}
