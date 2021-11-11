#!/usr/bin/env perl
# Week 138 Task 1
# Workdays

use strict;
use warnings;
use feature qw/ say /;
use DateTime;

my $year              = $ARGV[0];
my $dt                = DateTime->new( year => $year, month => 1, day => 1 );
my $start_day_of_week = $dt->day_of_week();
my $is_leap_year      = $dt->is_leap_year();
my %workdays          = (
    10 => 261,
    11 => 262,
    20 => 261,
    21 => 262,
    30 => 261,
    31 => 262,
    40 => 261,
    41 => 262,
    50 => 261,
    51 => 261,
    60 => 260,
    61 => 260,
    70 => 260,
    71 => 261,
);

say $workdays{"$start_day_of_week$is_leap_year"};
