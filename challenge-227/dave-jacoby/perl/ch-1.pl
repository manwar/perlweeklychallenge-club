#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use DateTime;

my @examples = (
    1753,
    1800,
    1900,
    2000,
    2009, 
    2023,
    2100,
    3000,
    4000,
    9000,
    9999
);

for my $year (@examples) {
    my $count = find_friday13s($year);
    say <<~"END";
    Input:  \$year = $year
    Output: $count
    END
}

sub find_friday13s ($year) {
    my $count = 0;
    my @months;
    for my $month ( 1 .. 12 ) {
        my $dt = DateTime->now();
        $dt->set_year($year);
        $dt->set_day(13);
        $dt->set_month($month);
        $count++ if $dt->day_of_week == 5;
        push @months, $month if $dt->day_of_week == 5;

    }
    return $count;
}
