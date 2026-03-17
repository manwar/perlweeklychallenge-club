#!/usr/bin/env perl

# Perl Weekly Challenge 259 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/

use Modern::Perl;
use DateTime;

my $start_date = parse_date(shift @ARGV);
my $offset = shift @ARGV;
my @holidays;
push @holidays, parse_date($_) for @ARGV;

my $end_date = compute_offset($start_date, $offset, @holidays);
say $end_date->ymd;

sub compute_offset {
    my($start_date, $offset, @holidays) = @_;
    my %holidays; $holidays{$_}=1 for @holidays;

    my $date = $start_date;
    for (1 .. $offset) {
        my $dow;
        do {
            $date->add(DateTime::Duration->new(days=>1));
            $dow = $date->day_of_week;
        } while ($dow==6 || $dow==7 || exists $holidays{$date});
    }
    return $date;
}

sub parse_date {
    my($text) = @_;
    my($year, $month, $day) = split /-/, $text;
    return DateTime->new(year=>$year, month=>$month, day=>$day);
}
