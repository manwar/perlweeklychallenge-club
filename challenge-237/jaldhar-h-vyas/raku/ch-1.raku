#!/usr/bin/raku

sub ordinal($day) {

    return $day ~ (
        $day % 10 == 1 && $day != 11
        ?? 'st'
        !! $day % 10 == 2 && $day != 12
            ?? 'nd'
            !! $day % 10 == 3 && $day != 13
                ?? 'rd'
                !! "th"
    );
}

sub MAIN(
    $year, $month, $weekday, $dayofweek
) {
    my $dt = Date.new(year => $year, month => $month, day => 1);

    my $diff = abs($dayofweek -  $dt.day-of-week);

    $dt += (7 * ($weekday - 1)) + $diff;

    my %d_abbr = (
        1 => 'Mon',
        2 => 'Tue',
        3 => 'Wed',
        4 => 'Thu',
        5 => 'Fri',
        6 => 'Sat',
        7 => 'Sun',
    );

    my %m_abbr = (
         1 => 'Jan',
         2 => 'Feb',
         3 => 'Mar',
         4 => 'Apr',
         5 => 'May',
         6 => 'Jun',
         7 => 'Jul',
         8 => 'Aug',
         9 => 'Sep',
        10 => 'Oct',
        11 => 'Nov',
        12 => 'Dec',
    );

    if $dt.month != $month {
        say "There isn't a ", ordinal($weekday), ' ', %d_abbr{$dayofweek},
            ' in ', %m_abbr{$month}, ' ', $year;
    } else {
        say 'The ', ordinal($weekday), ' ', %d_abbr{$dayofweek},' of ',
            %m_abbr{$month}, ' ', $year, ' is the ', ordinal($dt.day);
    }
}