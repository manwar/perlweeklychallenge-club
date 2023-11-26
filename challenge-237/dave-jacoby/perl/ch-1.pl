#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use DateTime;

my @examples = (

    { Year => 2024, Month => 4,  Weekday_of_month => 3, day_of_week => 2 },
    { Year => 2025, Month => 10, Weekday_of_month => 2, day_of_week => 4 },
    { Year => 2026, Month => 8,  Weekday_of_month => 5, day_of_week => 3 },
);

for my $e (@examples) {
    my $output = seize_the_day($e);
    say <<~"END";
    Input:  Year             = $e->{Year}, 
            Month            = $e->{Month}, 
            Weekday of month = $e->{Weekday_of_month}, 
            Day of week      = $e->{day_of_week}
    Output: $output
    END
}

sub seize_the_day ($day) {
    my $dt =
        DateTime->now->set_year( $day->{Year} )->set_month( $day->{Month} )
        ->set_day(1);
    my $c = 0;
    while ( $dt->month == $day->{Month} ) {
        $c++ if $dt->day_of_week == $day->{day_of_week};
        return $dt->day
            if $dt->day_of_week == $day->{day_of_week}
            and $c == $day->{Weekday_of_month};
        $dt->add( days => 1 );
    }
    return 0;
}
