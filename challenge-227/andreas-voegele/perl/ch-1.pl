#!/usr/bin/perl

# You are given a year number in the range 1753 to 9999.  Write a script to
# find out how many dates in the year are Friday 13th.  Assume that the
# current Gregorian calendar applies.

use 5.036;
use utf8;

use POSIX qw(mktime);

sub friday_13th ($year) {
    my $_year  = $year - 1900;
    my $mkdate = sub ($month) { mktime(0, 0, 0, 13, $month, $_year) };
    return grep { (localtime $_)[6] == 5 } map { $mkdate->($_) } 0 .. 11;
}

say scalar friday_13th(1753);
say scalar friday_13th(2023);
say scalar friday_13th(9999);
