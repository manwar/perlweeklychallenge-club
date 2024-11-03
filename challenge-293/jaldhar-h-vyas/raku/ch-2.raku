#!/usr/bin/raku

sub isBoomerang(@points) {
    my ($x1, $y1) = @points[0];
    my ($x2, $y2) = @points[1];
    my ($x3, $y3) = @points[2];

    if ($x1 == $x2 && $y1 == $y2) ||
    ($x1 == $x3 && $y1 == $y3) ||
    ($x2 == $x3 && $y2 == $y3) {
        return False ;
    }

    my $area = $x1 * ($y2 - $y3) + $x2 * ($y3 - $y1) + $x3 * ($y1 - $y2);
    return $area != 0;
}

sub MAIN(
    *@args
) {
    my @points = @args.map({ .split(q{ }) });
    say isBoomerang(@points);
}
