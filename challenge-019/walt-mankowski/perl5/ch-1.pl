#!/usr/bin/env perl

# Perl Weekly Challenge 019-1
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-019/
#
# Write a script to display months from the year 1900 to 2019 where
# you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);
use Time::Local;

# Looking at March 2019 it's clear that this can only happen if the
# month has 31 days and starts on a Friday:
#
#      March 2019
# Su Mo Tu We Th Fr Sa
#                 1  2
#  3  4  5  6  7  8  9
# 10 11 12 13 14 15 16
# 17 18 19 20 21 22 23
# 24 25 26 27 28 29 30
# 31

my @months = (0, 2, 4, 6, 7, 9, 11);

for my $year (1900..2019) {
    for my $month (@months) {
        if (starts_on_friday($year, $month)) {
            printf "%d/%02d\n", $year, $month+1;
        }
    }
}

# does the month starts with a Friday?
sub starts_on_friday($year, $month) {
    my $time = timelocal(undef, undef, undef, 1, $month, $year);
    return (localtime($time))[6] == 5;
}
