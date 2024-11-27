#!/usr/bin/env perl

# Challenge 178
#
# Task 2: Business Date
# Submitted by: Mohammad S Anwar
#
# You are given $timestamp (date with time) and $duration in hours.
#
# Write a script to find the time that occurs $duration business hours after
# $timestamp. For the sake of this task, let us assume the working hours is 9am
# to 6pm, Monday to Friday. Please ignore timezone too.
#
# For example,
#
# Suppose the given timestamp is 2022-08-01 10:30 and the duration is 4 hours.
# Then the next business date would be 2022-08-01 14:30.
#
# Similar if the given timestamp is 2022-08-01 17:00 and the duration is 3.5 hours.
# Then the next business date would be 2022-08-02 11:30.

use Modern::Perl;
use DateTime;

sub next_business_date {
    my($date_text, $time_text, $hours) = @_;
    "$date_text $time_text" =~ /^(\d+)-(\d+)-(\d+) (\d+):(\d+)$/
        or die "invalid date";
    my $date = DateTime->new(year=>$1, month=>$2, day=>$3, hour=>$4, minute=>$5);
    my $minutes = $hours*60;
    while (1) {
        (my $end_day = $date->clone)->set(hour=>18, minute=>0);
        my $remain = $end_day->subtract_datetime($date)->in_units('minutes');
        if ($remain > $minutes) {
            $date->add(minutes=>$minutes);
            return $date;
        }
        else {
            $minutes -= $remain;
            ($date = $end_day)->add(hours=>(24-18)+9);
            $date->add(days=>1) while $date->day_of_week >= 6;  # skip weekend
        }
    }
}

@ARGV==3 or die "usage: ch-2.pl yyyy-mm-dd HH:MM hours\n";
say next_business_date(@ARGV)->strftime("%Y-%m-%d %H:%M");
