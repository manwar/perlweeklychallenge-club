#!/bin/env raku

sub MAIN(Str:D $matrix-file where $matrix-file.IO.e) {
    my @N;
    @N.push(.words) for $matrix-file.IO.lines;

    my $cnt = 0;
    for 0..^@N[0].elems-1 X 0..^@N.elems-1 -> ($i, $j) {
        for 1..min(@N[0].elems-$i-1, @N.elems-$j-1) -> $size {
            ++$cnt if all(@N[$i;$j], @N[$i;$j+$size], @N[$i+$size;$j], @N[$i+$size;$j+$size]) == 1;
        }
    }

    put $cnt;
}
