#!/usr/bin/env raku

class Point {
    has Int $.x;
    has Int $.y;

    multi method new($x, $y) {
        self.bless(:$x, :$y);
    }
}

sub challenge(Point $A, Point $B, Point $C, Point $target = Point.new(0, 0)) returns Int {
    my $area = 0.5 * (-$B.y * $C.x + $A.y * (-$B.x + $C.x) + $A.x * ($B.y - $C.y) + $B.x * $C.y);
    my $s = 1 / (2 * $area) * ($A.y * $C.x - $A.x * $C.y + ($C.y - $A.y) * $target.x + ($A.x - $C.x) * $target.y);
    my $t = 1 / (2 * $area) * ($A.x * $B.y - $A.y * $B.x + ($A.y - $B.y) * $target.x + ($B.x - $A.x) * $target.y);
    (0 <= $s <= 1 && 0 <= $t <= 1 && $s + $t <= 1).Int;
}

multi sub MAIN(Int $x1, Int $y1, Int $x2, Int $y2, Int $x3, Int $y3) {
    say challenge(
        Point.new($x1, $y1),
        Point.new($x2, $y2),
        Point.new($x3, $y3)
    );
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (Point.new(0, 1), Point.new(1, 0),  Point.new(2, 2),  0),
        (Point.new(1, 1), Point.new(-1, 1), Point.new(0, -3), 1),
        (Point.new(0, 1), Point.new(2, 0),  Point.new(-6, 0), 1)
    );

    for @tests -> ($A, $B, $C, $expected) {
        is(challenge($A, $B, $C), $expected);
    }

    done-testing;
}
