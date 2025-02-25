#!/bin/env raku

unit sub MAIN(*@ints);

while +@ints > 1 {
    my ($x, $y) = @ints.sort.tail(2);
    my $i = @ints.first($x, :k);
    @ints.splice($i, 1);
    $i = @ints.first($y, :k);
    if $x == $y {
        @ints.splice($i, 1);
    } else {
        @ints.splice($i, 1, $y-$x);
    }
}
put +@ints ?? @ints[0] !! 0;
