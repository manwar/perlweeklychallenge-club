#!/usr/bin/perl -s

use v5.16;
use warnings;
use Date::Manip::Recur;

main: {
    # A month with five Fridays and five Sundays has five Saturdays,
    # too.

    # Find all months having five Fridays.
    my @fridays = map $_->printf('%Y/%m'),
        Date::Manip::Recur->new('5th Friday of every month',
        undef, 1900, 2020)->dates;
    # Find all months having five Sundays.
    my @sundays = map $_->printf('%Y/%m'),
        Date::Manip::Recur->new('5th Sunday of every month',
        undef, 1900, 2020)->dates;

    # Build a hash having the months with five Fridays as keys and
    # values.
    my %fridays;
    @fridays{@fridays} = @fridays;
    # Find the intersection between months with five Fridays and five
    # Sundays.
    say for grep defined, @fridays{@sundays};
}
