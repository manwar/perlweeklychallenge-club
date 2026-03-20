#!/usr/bin/env perl

# Perl Weekly Challenge 227 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-227/

use Modern::Perl;
use DateTime;

my $year = shift or die "Usage: $0 year\n";
say num_friday13th($year);

sub num_friday13th {
    my($year) = @_;
    my $count = 0;
    for my $month (1..12) {
        my $dt = DateTime->new(year=>$year, month=>$month, day=>13);
        my $dow = $dt->day_of_week;
        $count++ if $dow==5;    # friday
    }
    return $count;
}
