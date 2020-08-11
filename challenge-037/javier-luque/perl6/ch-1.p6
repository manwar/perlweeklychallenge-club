# Test: perl6 ch1.p6 2019
use v6.d;

sub MAIN(Int $year = 2019) {
    show-weekdays-per-year($year);
}

# Weekdays per year
sub show-weekdays-per-year(Int $year) {
    my $current = Date.new($year, 1, 1);
    my %months{Int};

    my @mon = (
        'Jan', 'Feb', 'Mar', 'Apr',
        'May', 'Jun', 'Jul', 'Aug',
        'Sep', 'Oct', 'Nov', 'Dec'
    );

    while ($current.year == $year) {
        %months{$current.month}++
            if ($current.day-of-week == (1 .. 5).any);
        $current++;
    }

    for %months.keys.sort -> $key {
        say @mon[$key - 1] ~ ': ' ~
            %months{$key} ~ ' days';
    }
}
