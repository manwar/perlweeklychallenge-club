#!/usr/bin/env raku

class Point {
    has $.x;
    has $.y;

    multi method new($x, $y) {
        self.bless(:$x, :$y);
    }
}

class Line {
    has $.slope;
    has $.x-intercept;
    has $.y-intercept;
    has Set $.points is rw;
}

sub challenge(@points) {
    my %lines;
    for @points.kv -> $index, $point {
        for @points[$index+1..*] -> $other-point {
            my $numerator = $other-point.y - $point.y;
            my $denominator = $other-point.x - $point.x;

            my $slope = $denominator == 0 ?? 'undefined' !! $numerator / $denominator;

            my $y-intercept;
            if $slope eq 'undefined' {
                $y-intercept = $point.y == 0 ?? 0 !! 'undefined';
            } else {
                $y-intercept = $point.y - ($slope * $point.x);
            }

            my $x-intercept;
            if $slope eq 'undefined' {
                $x-intercept = $point.x;
            } elsif $slope == 0 {
                $x-intercept = 'undefined'
            } else {
                $x-intercept = -$y-intercept / $slope;
            }

            my $points = Set.new("{$point.x},{$point.y}", "{$other-point.x},{$other-point.y}");

            my $key = "$slope,$x-intercept,$y-intercept";
            if %lines{$key}:exists {
                %lines{$key}.points ∪= $points;
            } else {
                %lines{$key} = Line.new(:$slope, :$x-intercept, :$y-intercept, :$points);
            }
        }
    }
    %lines.max({ $_.value.points.elems }).value.points.elems;
}

multi sub MAIN(*@N where all(@N) ~~ Int && @N.elems %% 2) {
    my @pairs = @N.map(-> $x, $y { Point.new($x, $y) });
    say challenge(@pairs);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ((Point.new(1, 1), Point.new(2, 2), Point.new(3, 3)), 3),
        ((Point.new(1, 1), Point.new(2, 2), Point.new(3, 1), Point.new(1, 3), Point.new(5, 3)), 3),
        ((Point.new(1, 1), Point.new(2, 1), Point.new(3, 1), Point.new(4, 1)), 4),
        ((Point.new(1, 1), Point.new(1, 2), Point.new(2, 1), Point.new(3, 1), Point.new(4, 1)), 4)
    );

    for @tests -> (@points, $expected) {
        is(challenge(@points), $expected);
    }

    done-testing;
}
