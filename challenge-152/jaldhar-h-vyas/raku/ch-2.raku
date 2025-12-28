#!/usr/bin/raku

sub MAIN(
    $rect1,
    $rect2
) {
    my ($x1a, $y1a, $x2a, $y2a) = $rect1.split(',');
    my ($x1b, $y1b, $x2b, $y2b) = $rect1.split(',');

    my $area1 = ($x2a - $x1a) * ($y2a - $y1a);
    my $area2 = ($x2b - $x1b) * ($y2b - $y1b);

    my $overlapx1 = $x1a max $x1b;
    my $overlapy1 = $y1a max $y1b;
    my $overlapx2 = $x2a min $x2b;
    my $overlapy2 = $y2a min $y2b;

    my $overlapArea = 0;
    if $overlapx2 > $overlapx1 && $overlapy2 > $overlapy1 {
        $overlapArea =
            ($overlapx2 - $overlapx1) * ($overlapy2 - $overlapy1);
    }

    say $area1 + $area2 - $overlapArea;
}
