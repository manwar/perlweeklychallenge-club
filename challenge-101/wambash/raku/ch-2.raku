#!/usr/bin/env raku

class Point {
    has ($.x, $.y);

    multi method COERCE ( ($x,$y) ) {
        self.new: :$x, :$y
    }
}


class Line {
    has ($.a, $.b, $.c);

    method from-points (Point:D() $p, Point:D() $q) {
        my $b = $p.x-$q.x;
        my $a = $q.y-$p.y;
        my $c = $a*$p.x + $b*$p.y;
        self.new: :$a, :$b, :$c
    }

    method gist () {
        "$.a·x + $.b·y = $.c"
    }
}

sub origin-in-half-plane ( Line:D $l, Point:D() $p) {
    ($l.a*$p.x + $l.b*$p.y - $l.c) * $l.c ≤ 0
}

sub origin-in-triangle ( Point:D @p ) {
    my @line = @p.combinations(2).map: {Line.from-points(|$_) };
    @line Z, @p.reverse
    andthen .map: { origin-in-half-plane |$_ }\
    andthen .all
}

multi MAIN (
    +@point    #= 0 1  1 0  2 2
    ) {
    @point
    andthen .batch: 2
    andthen Array[Point()].new: $_
    andthen origin-in-triangle $_
    andthen say + .so
}

multi MAIN (Bool :$test!) {
    use Test;

    my $l = Line.from-points: (-1,2), (3,4) ;
    is $l.gist, '2·x + -4·y = -10';
    is $l.a * 3 + $l.b * 4, $l.c;

    is origin-in-half-plane( $l, (1,1) ), True;
    is origin-in-half-plane( $l, (-5,1) ), False;

    my Point() @point0 = (1,2), (3,4), (1,-2);
    nok origin-in-triangle @point0;

    my Point() @point1 = (0,1), (1,0), (2,2);
    nok origin-in-triangle @point1;

    my Point() @point2 = (1,1), (-1,1), (0,-3);
    ok origin-in-triangle @point2;

    my Point() @point3 = (0,1), (2,0), (-6,0);
    ok origin-in-triangle @point3;

    done-testing;
}
