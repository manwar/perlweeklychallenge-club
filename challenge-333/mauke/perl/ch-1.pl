use v5.40;

sub gcd($x, $y) {
    while () {
        ($x, $y) = ($y, $x)
            if $x > $y;
        return $y
            if $x == 0;
        my $d = $y - $x;
        $y = $x;
        $x = $d;
    }
}

sub shifted(@points) {
    map {
        my $vx = $_->[0] - $points[0][0];
        my $vy = $_->[1] - $points[0][1];
        $vx && $vy ? [$vx, $vy] : ()
    } @points
}

sub reduce($f) {
    my $t = gcd $f->[0], $f->[1];
    [ $f->[0] / $t, $f->[1] / $t ]
}

sub forms_straight_line(@points) {
    my @shifted = shifted @points
        or return true;
    my $g = reduce shift @shifted;
    for my $point (@shifted) {
        my $f = reduce $point;
        $f->[0] == $g->[0] && $f->[1] == $g->[1]
            or return false;
    }
    true
}

for my $input (
    [[2, 1], [2, 3], [2, 5]],
    [[1, 4], [3, 4], [10, 4]],
    [[0, 0], [1, 1], [2, 3]],
    [[1, 1], [1, 1], [1, 1]],
    [[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]],
) {
    say forms_straight_line(@$input) ? "true" : "false";
}
