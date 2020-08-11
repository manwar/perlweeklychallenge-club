#!/usr/bin/env perl

use Modern::Perl;
use Time::Piece;

# Write a script to list dates for Sunday Christmas between 2019 and 2100.
# For example, 25 Dec 2022 is Sunday.

for my $year ( 2019 .. 2100 ) {
    my $christmas_day = Time::Piece->strptime( "$year-12-25", '%F' );
    say $christmas_day->strftime('%A %F') if $christmas_day->day_of_week == 0;    # sunday
}
