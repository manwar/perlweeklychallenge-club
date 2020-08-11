use v6;

sub MAIN (UInt $yr = 2019) {
    for 1..12 -> $mth {
        my $weekdays = 20;
        for 29..Date.new($yr, $mth, 1).days-in-month -> $day {
            $weekdays++ if
                Date.new($yr, $mth, $day).day-of-week == (1..5).any;
        }
        printf "%02d/%d has $weekdays week days.\n", $mth, $yr;
    }
}
