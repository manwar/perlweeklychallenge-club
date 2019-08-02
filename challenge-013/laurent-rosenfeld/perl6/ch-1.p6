use v6;

sub MAIN (UInt $year = 2019) {
    my $year-length =
        DateTime.new(:year($year)).is-leap-year ?? 366 !! 365;
    my $day = Date.new("$year-01-01");
    my $month = 1;
    my $last-friday;
    for 1..$year-length {
         $day = $day.succ;
         next unless $day.day-of-week == 5;
         if $day.month != $month {
            $month = $day.month;
            say $last-friday;
        }
        $last-friday = $day;
    }
    say $last-friday;
}
