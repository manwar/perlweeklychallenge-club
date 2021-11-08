use v6;

class Point {
    has $.x;    # abscissa
    has $.y;    # ordinate

    method gist { return "[x => $!x y => $!y]"}
}

sub dist (Point $a, Point $b) {
    return sqrt( ($b.x - $a.x)² + ($b.y - $a.y)² );
}

sub build4points (@in) {
    my @points;
    for @in -> $x, $y {
        push @points, Point.new(x => $x, y => $y)
    }
    return @points;
}

my @tests = <10 20 20 20 20 10 10 10>,
            <12 24 16 10 20 12 18 18>;
for @tests -> @test {
    my @p = build4points @test;
    my %dist;
    for (@p).combinations: 2 -> $c {
        %dist{dist($c[0], $c[1])}++;
    }
    # say %dist;
    print @test, " => ";
    if any(values %dist) == 4 {say 1;} else {say 0}
}
