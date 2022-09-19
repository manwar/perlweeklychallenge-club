sub last_sunday_of (  $year,  $month ) {
    my $d = Date.new(:$year, :$month).last-date-in-month;

    return $d - $d.day-of-week % 7;
}
sub MAIN ( UInt $year = 2022 ) {
    say last_sunday_of( $year, $_ ) for 1..12;
}

# Alternate approach:
# my @s;
# @s[.month - 1] = $_ if .day-of-week == 7 for Date.new($year  , 1, 1)
#                                          ..^ Date.new($year+1, 1, 1);
# .say for @s;
