#!/usr/bin/perl
# Test: ./ch1.pl 2019
use strict;
use warnings;
use feature qw /say/;
use DateTime;
use DateTime::Event::Recurrence;

show_weekdays_per_year($ARGV[0]);

sub show_weekdays_per_year {
    my $year = shift || 2019;
    for my $month (1..12) {
        show_weekdays_per_month($month, $year);
    }
}

sub show_weekdays_per_month {
    my ($month, $year) = @_;

    my $working_days =
        DateTime::Event::Recurrence->weekly(
            days => [1 .. 5]
        );

    # Start of the month
    my $start = DateTime->new(
        year  => $year,
        month => $month,
        day   => 1
    );

    # End of the month
    my $end = $start->clone;
    $end->add( months => 1 )
        ->subtract( days => 1 );

    my $num_days = $working_days->as_list(
        start => $start,
        end => $end
    );

    say $start->month_abbr() . ": $num_days days";
}
