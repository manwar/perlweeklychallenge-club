#!/usr/bin/env raku
class Point {
    has $.x;
    has $.y;

    method COERCE ( @list ) {
        Point.new: x => @list.[0], y => @list.[1];
    }
}

sub square-points ( Point() $a, Point() $b, Point() $c, Point() $d ) {
    ($a.x - $c.x)*($b.x - $d.x) + ($a.y - $c.y)*($b.y-$d.y) == 0
    and
    ($a.x - $c.x)² + ($a.y - $c.y)² ==  ($b.x - $d.x)² + ($b.y - $d.y)²
}

multi MAIN (*@points) {
    say square-points |@points.batch(2)
}

multi MAIN (Bool :test($)!) {
    use Test;
    ok square-points((10,20),(20,20),(20,10),(10,10));
    nok square-points((12,24),(16,10),(20,12),(18,16));
    done-testing;
}
