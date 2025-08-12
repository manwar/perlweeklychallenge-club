#!/usr/bin/raku

sub manhattanDistance($x, $y, $x1, $y1) {
    return ($x1 - $x).abs + ($y1 - $y).abs;
}

sub MAIN(
    Int $x,
    Int $y,
    *@points
) {
    my $smallestDistance = ∞;
    my $smallestPoint = -1;

    for @points.keys -> $point {
        my ($x1, $y1) = @points[$point].split(',')».Int;

        if $x1 == $x || $y1 == $y {
            my $distance = manhattanDistance($x, $y, $x1, $y1);

            if $distance < $smallestDistance {
                $smallestDistance = $distance;
                $smallestPoint = $point;
            }
        }
    }

    say $smallestPoint;
}