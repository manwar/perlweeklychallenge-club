#!/usr/bin/raku

class Point {
    has Int $.x;
    has Int $.y;

    multi method new (Str $str) {
        $str ~~ / ^ ( \-* \d+ ) \, ( \-* \d+ ) $ /;
        self.bless( x => $0.Int, y => $1.Int );
    }

    multi method new (Int $x, Int $y) {
        self.bless( x => $x, y => $y);
    }
}

class Triangle {
    has Point $!p1;
    has Point $!p2;
    has Point $!p3;
    has Numeric $.area;

    method new (Point $a, Point $b, Point $c) {
        self.bless(p1 => $a, p2 => $b, p3 => $c);
    }

    submethod BUILD (Point :$!p1, Point :$!p2, Point :$!p3) {
        $!area = abs( 
            (
                $!p1.x * ($!p2.y - $!p3.y) +
                $!p2.x * ($!p3.y - $!p1.y) +
                $!p3.x * ($!p1.y - $!p2.y)
            ) / 2.0
        );
    }
}

sub isInside (Point $a, Point $b, Point $c, Point $p) {

    my $area0 = Triangle.new($a, $b, $c).area;
    my $area1 = Triangle.new($p, $b, $c).area;
    my $area2 = Triangle.new($a, $p, $c).area;
    my $area3 = Triangle.new($a, $b, $p).area;

    return ($area0 == $area1 + $area2 + $area3);
}

sub MAIN (
    #= a point is a pair of integers separated by a comma
    Str $Point1,
    Str $Point2,
    Str $Point3
) {
    my $a = Point.new($Point1);
    my $b = Point.new($Point2);
    my $c = Point.new($Point3);
    my $p = Point.new(0, 0);

    say isInside($a, $b, $c, $p) ?? 1 !! 0;
}