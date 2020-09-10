#!/bin/env perl

use Modern::Perl;
use Date::Manip;

sub is_leap_year {
    my $year = shift;

    return 1 if $year % 400 == 0;
    return 0 if $year % 100 == 0;
    return 1 if $year %   4 == 0;
    return 0;
}

exit if @ARGV < 1;
my $year = $ARGV[0];

my @last_days = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
$last_days[1] = 29 if is_leap_year($year);

for my $month (1..12) {
    my $d = ParseDate("$year-$month-". $last_days[$month - 1]);
    say UnixDate(DateCalc($d, sprintf('- %d days', (UnixDate($d, '%w') - 5) % 7)), '%Y/%m/%d');
}
