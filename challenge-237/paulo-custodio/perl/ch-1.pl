#!/usr/bin/env perl

# Perl Weekly Challenge 237 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-237/

use Modern::Perl;
use DateTime;

my($year, $month, $wdom, $dow) = @ARGV;
say find($year, $month, $wdom, $dow);

sub find {
    my($year, $month, $wdom, $dow) = @_;
    my $count = 0;
    for my $day (1 .. DateTime->last_day_of_month(year=>$year, month=>$month)->day) {
        my $dt = DateTime->new(year=>$year, month=>$month, day=>$day);
        if ($dt->dow == $dow) {
            $count++;
            if ($count==$wdom) {
                return $day;
            }
        }
    }
    return 0;
}
