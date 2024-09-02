#!/usr/bin/env perl

# Challenge 259
#
# Task 1: Banking Day Offset
# Submitted by: Lee Johnson
#
# You are given a start date and offset counter. Optionally you also get bank
# holiday date list.
#
# Given a number (of days) and a start date, return the number (of days)
# adjusted to take into account non-banking days. In other words: convert a
# banking day offset to a calendar day offset.
#
# Non-banking days are:
#
# a) Weekends
# b) Bank holidays
#
# Example 1
#
# Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
# Output: '2018-07-04'
#
# Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)
#
# Example 2
#
# Input: $start_date = '2018-06-28', $offset = 3
# Output: '2018-07-03'

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
