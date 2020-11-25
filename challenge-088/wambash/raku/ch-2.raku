#!/usr/bin/env raku

my @matrix = [
    [ 1, 2, 3 ],
    [ 4, 5, 6 ],
    [ 7, 8, 9 ],
    ];

sub rotate-left (+@n) {
    @n[0].keys
    andthen .reverse
    andthen .map: { @n[*;$_] }\
}

sub spiral-matrix (+@n) {
    \( matrix => @n, spiral => Empty ),  { \( matrix => .<matrix>.skip.&rotate-left, spiral => .<matrix>.head )  } ... !*.<matrix>
    andthen .map: *.<spiral>
}

multi MAIN (Bool :$test!) {
    use Test;

    my @matrix = (
        1, 2, 3 ;
        4, 5, 6 ;
        7, 8, 9 ;
    );
    my $rotated = (
        3,6,9;
        2,5,8;
        1,4,7;
    );
    my @matrix2 = (
         1,  2,  3,  4 ;
         5,  6,  7,  8 ;
         9, 10, 11, 12 ;
        13, 14, 15, 16 ;
    );

    is-deeply rotate-left(@matrix), $rotated;
    is spiral-matrix(@matrix),  (1, 2, 3, 6, 9, 8, 7, 4, 5);
    is spiral-matrix(@matrix2), (1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10);
}
