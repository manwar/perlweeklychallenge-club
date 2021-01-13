#!/usr/bin/env perl6

use v6.d;

#| Find the palendromic numbers (writen mmddyyy) between 2000-01-01 and 2999-01-01
sub MAIN() {
    my sub df( Date $d) {
        # Bleh American dates
        sprintf "%02d%02d%04d", .month, .day, .year given $d;
    }

    constant START = Date.new(2000,1,1,formatter => &df);
    constant END = Date.new(2999,12,31, formatter => &df);

    my @out;
    
    for (1..12) -> $month {
        for (1..31) -> $day {
            my $date;
            my $year = sprintf( "%02d%02d", $month, $day ).flip;
            try {
                $date = Date.new($year,$month,$day,formatter => &df);
            }
            next unless $date;
            next unless START <= $date <= END;
            @out.push($date);
        }
    }

    .say for @out.sort;
}


     
