use 5.040; # for true and false

sub straight_line(@coordinates) {
    if (@coordinates < 4 || @coordinates % 2) {
        return @coordinates == 2;
    }

    my ($x0,$y0,$x1,$y1) = splice @coordinates, 0, 4;
    # need to find a different second point to define the line
    while ($x1 == $x0 && $y1 == $y0) {
        ($x1,$y1) = splice @coordinates, 0, 2 or last;
    }
    while (my ($x,$y) = splice @coordinates, 0, 2) {
        return false if ($y-$y0)*($x1-$x0) != ($x-$x0)*($y1-$y0);
    }
    return true;
}

sub main() {
    my @inputs = @ARGV;

    say straight_line(@inputs) ? 'true' : 'false';

    return;
}

main() unless caller;
