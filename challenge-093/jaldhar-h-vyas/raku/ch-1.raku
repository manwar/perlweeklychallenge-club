#!/usr/bin/raku

sub MAIN(
    *@N where { @N.elems } #= x1,y1 x2,y2 ...
 ) {
    my @points = @N.map({ [ $_.split(q{,}) ] });
    my $maxPoints = 1;

    for @points.keys -> $i {
        my %lines;

        for @points.keys -> $j {

            if $i == $j {
                next;
            }

            my ($x1, $y1) = @points[$i];
            my ($x2, $y2) = @points[$j];
            my ($dx, $dy) = ($x2 - $x1, $y2 - $y1);

            if $dx == 0 {
                %lines{∞}++;
            } else {
                my $slope = $dy / $dx;
                my $intercept = $y1 - $slope * $x1;
                %lines{"$slope,$intercept"}++;
            }
        }

        my $localMax = (%lines.values.max // 0) + 1;

        $maxPoints = ($maxPoints, $localMax).max;
    }

    say $maxPoints;
}