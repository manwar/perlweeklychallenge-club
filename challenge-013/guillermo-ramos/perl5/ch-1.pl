#!/usr/bin/env perl
#
# Write a script to print the date of last Friday of every month of a given year
################################################################################

use strict;
use warnings;

use Time::Local qw<timelocal>;

die "Usage: $0 <year>\n" unless @ARGV == 1;
my $year = shift;

my %last_dom = (
    0 => 31, 1 => 28, 2 => 31, 3 => 30, 4 => 31, 5 => 30,
    6 => 31, 7 => 31, 8 => 30, 9 => 31, 10 => 30, 11 => 31
    );

foreach my $month (0..11) {
    my $last_day = $last_dom{$month};
    my $last_wday = (localtime timelocal(0, 0, 0, $last_day, $month, $year))[6];
    my $last_friday = $last_day - $last_wday + ($last_wday >= 5 ? 5 : -2);
    printf "%d/%02d/%d\n", $year, $month+1, $last_friday;
}
