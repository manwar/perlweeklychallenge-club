sub MAIN (Int $yr = 2022) {
    for ('01'..'09', 10 .. 12).flat -> $month {
        my $month-end = Date.new("$yr-$month-01").last-date-in-month;
        my $week_day = $month-end.day-of-week;
        my $day-in-month = $month-end.day-of-month;
        # Note: Sunday is weekday 7
        my $sunday = $day-in-month - ($week_day % 7);
        say Date.new("$yr-$month-$sunday");
    }
}
