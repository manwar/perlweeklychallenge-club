#!/usr/bin/raku

sub MAIN(
    Int $x1, Int $y1, Int $x2, Int $y2, Int $x3, Int $y3, Int $x4, Int $y4
) {

    say (abs($x1 - $x3) == abs($x2 - $x4) &&
        abs($y1 - $y2) == abs($y3 - $y4)) ?? 1 !! 0;
}