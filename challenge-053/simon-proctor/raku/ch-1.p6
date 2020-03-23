#!/usr/bin/env raku

use v6;

subset Rotation of Int where * ~~ 0|90|180|270;

#| Rotate the 3x3 matrix of 1 to 9 through 0, 90, 180 or 270 degrees clockwise
sub MAIN (
    Rotation $rotate is copy, #= Degrees to rotate clockwise through, 0, 90, 180 or 270
) {
    my @matrix =
    [
        [1,2,3],
        [4,5,6],
        [7,8,9]
    ];

    while $rotate > 0 {
        $rotate -= 90;
        @matrix = rotate-matrix( @matrix );
    };

    @matrix.map( *.join( " " ) ).join("\n").say;
}

sub rotate-matrix ( @m ) {
    [
        [@m[2][0], @m[1][0], @m[0][0]],
        [@m[2][1], @m[1][1], @m[0][1]],
        [@m[2][2], @m[1][2], @m[0][2]]
    ]
}
