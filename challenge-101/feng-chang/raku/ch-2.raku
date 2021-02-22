#!/bin/env raku

class Point {
    has Int $.x;
    has Int $.y;
}

sub area(Point:D $a, Point:D $b, Point:D $c) {
    abs(($a.x * ($b.y - $c.y) + $b.x * ($c.y - $a.y) +  $c.x * ($a.y - $b.y)) / 2); 
}

sub USAGE() {
    say "Usage: {$*PROGRAM-NAME} <6 integers>";
}

multi MAIN(*@A where @A.elems == 6 && @A.all ~~ Int) {
    my Point $a .= new(x => @A[0], y => @A[1]);
    my Point $b .= new(x => @A[2], y => @A[3]);
    my Point $c .= new(x => @A[4], y => @A[5]);
    my Point $o .= new(x => 0, y => 0);

    say +(area($a, $b, $c) == area($a, $b, $o) + area($b, $c, $o) + area($c, $a, $o));
}
