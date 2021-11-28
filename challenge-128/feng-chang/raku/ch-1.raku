#!/bin/env raku

my method mat-size(List:D $coords where *.elems() == 4: --> UInt:D) {
    ($coords[2] - $coords[0] + 1) * ($coords[3] - $coords[1] + 1)
}

sub MAIN(Str:D $f where *.IO.e = 'input.txt') {
    my Array @mat .= push($_.comb.Array) for $f.IO.lines;

    my @A = (^@mat.elems X ^@mat[0].elems X ^@mat.elems X ^@mat[0].elems)
        .grep({ .[2] > .[0] and .[3] > .[1] })
        .grep({ @mat[.[0] .. .[2]; .[1] .. .[3]].all == 0 });
    my $max-size = @A.map(*.&mat-size).max;

    put "max size: $max-size";
    put @A.grep(*.&mat-size == $max-size).join("\n");
}
