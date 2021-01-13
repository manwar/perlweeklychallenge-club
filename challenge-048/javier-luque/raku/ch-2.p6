# Test: perl6 ch-2.p6
use v6.d;

sub MAIN () {
    my $current_date  = Date.new(2000, 1, 1);
    my $end_date = Date.new(2999, 12, 31);

    while ($current_date < $end_date) {
        # Format month and day
        my $month = ($current_date.month < 10) ??
            '0' ~ $current_date.month !!
            $current_date.month;

        my $day   = ($current_date.day < 10) ??
            '0' ~ $current_date.day !!
            $current_date.day;

        # Date String
        my $date_string = $month ~ $day ~ $current_date.year;

        # Output the datestring if it's a palindrome
        say $date_string
            if ($date_string eq $date_string.flip);

        # Next Day
        $current_date = $current_date + 1;
    }
}
