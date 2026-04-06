#!/usr/bin/env perl

# Perl Weekly Challenge 178 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-178/

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
