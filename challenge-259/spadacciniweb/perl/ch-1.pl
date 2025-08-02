#!/usr/bin/env perl

# Task 1: Banking Day Offset
# Submitted by: Lee Johnson
# 
# You are given a start date and offset counter. Optionally you also get bank holiday date list.
# 
# Given a number (of days) and a start date, return the number (of days) adjusted to take into account non-banking days. In other words: convert a banking day offset to a calendar day offset.
# 
# Non-banking days are:
# a) Weekends
# b) Bank holidays
# 
# Example 1
# Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
# Output: '2018-07-04'
# 
# Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)
# 
# Example 2
# Input: $start_date = '2018-06-28', $offset = 3
# Output: '2018-07-03'

use strict;
use warnings;
use DateTime;

my $start_date = '2018-06-28';
my $offset = 3;
my $bank_holidays = ['2018-07-03'];
banking_day_offset($start_date, $offset, $bank_holidays);

$start_date = '2018-06-28';
$offset = 3;
$bank_holidays = [];
banking_day_offset($start_date, $offset, $bank_holidays);

exit 0;

sub banking_day_offset {
    my $start_date = shift;
    my $offset = shift;
    my $bank_holidays = shift;

    my ($yyyy, $mm, $dd) = split /-/, $start_date;
    my $dt = DateTime->new(
        year  => $yyyy,
        month => $mm,
        day  => $dd
    );
    
    foreach (1..$offset) {
        $dt->add( days => 1 );
        while (no_banking_day($dt)) {
            $dt->add( days => 1 );
        }
    }

    printf "(start %s offset %s Bank holidays [%s]) -> %s\n",
        $start_date,
        $offset,
        (join ' / ', @$bank_holidays ),
        $dt->ymd;

    return undef;
}

sub no_banking_day {
    my $dt = shift;
    my $ymd = $dt->ymd;
    return 1
        if $dt->day_of_week >= 6
                ||
               grep /$ymd/, @$bank_holidays;
    return 0;
}
