use v6;

for 1900..2019 -> $year {
    for 1..12 -> $month {
        my $day = 1;
        my $date = Date.new($year, $month, $day);
        my $last-day-of-month =
            $date.later(month => 1).earlier(day => 1);
        ++$date until $date.day-of-week == 5;
        say $year, "-", $month.fmt("%02d"), " has 5 weekends"
            if $last-day-of-month - $date > 29;
    }
}
