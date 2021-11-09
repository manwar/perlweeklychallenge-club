#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

use DateTime;

for my $y ( 2000 .. 2040 ) {
    say join "\t", $y, workdays2($y), workdays1($y);
}

# The brute force solution, where I go through each year,
# checking if each day is a work day, and keeping count. 

sub workdays1 ( $year ) {
    my $day = DateTime->new(
        day       => 1,
        month     => 1,
        year      => $year,
        time_zone => 'floating'
    );
    my $c = 0;
    while ( $year == $day->year ) {
        $c++ if $day->day_of_week <= 5;
        $day->add( days => 1 );
    }
    return $c;
}

# But there are ONLY 14 years. Leap year or not = 2. Days of week = 7.
# 2 * 7 == 14. So it's perfectly reasonable to know that, if the year
# is a leapyar and starts on a Saturday, or starts on a Sunday, leap year
# or no, that's going to be a 260-workday year, and if it's a leap year
# and starts on Monday, Tuesday, Wednesday or Thurday, there will be
# 262, and otherwise, there will be 261.

sub workdays2( $year ) {
    my $table = {};
    $table->{0}{1} = 261;
    $table->{0}{2} = 261;
    $table->{0}{3} = 261;
    $table->{0}{4} = 261;
    $table->{0}{5} = 261;
    $table->{0}{6} = 260;
    $table->{0}{7} = 260;
    $table->{1}{1} = 262;
    $table->{1}{2} = 262;
    $table->{1}{3} = 262;
    $table->{1}{4} = 262;
    $table->{1}{5} = 261;
    $table->{1}{6} = 260;
    $table->{1}{7} = 261;
    my $day = DateTime->new(
        day       => 1,
        month     => 1,
        year      => $year,
        time_zone => 'floating'
    );
    return $table->{ $day->is_leap_year }{ $day->dow };
}

