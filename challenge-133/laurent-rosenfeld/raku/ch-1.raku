use v6;

sub sqroot (Int $a) {
    # Bisection approach
    my $start = 1;
    my $end = $a;
    my $est;
    loop {
        $est = ($start + $end) div 2;
        say "\tIntermediate values: $start, $est, and $end";
        my $est-sq = $est ** 2;
        last if abs($end-$start) <= 1;
        if $est ** 2 > $a {
            $end = $est;
        } else {
            $start = $est;
        }
    }
    return $est;
}
say "$_\t", sqroot $_ for 10, 27, 85, 101, 200_000_000;
