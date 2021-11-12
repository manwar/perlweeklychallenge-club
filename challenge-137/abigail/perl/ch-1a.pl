#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1a.pl
#

#
# A year is a long year if the last day of the year is a Thursday,
# or if the last day of the year is a Friday, and the year is a
# leap year.
#
# To determine the day of the week of Dec 31, we first calculate the
# Doomsday value of the year: this is the day of the week of 4/4,
# 6/6, 8/8, 10/10, 12/12, 5/9, 9/5, 7/11, 11/7, Pi day, the last
# day of February, and January 3 (non leap years) or January 4 (leap years)
#
# Given the day of the week of Dec 12, it's trivial to calculate the
# day of the week of Dec 31.
#
# See also ch-1.pl for an alternative method to solve this.
#

my $SUNDAY    = 0;
my $MONDAY    = 1;
my $TUESDAY   = 2;
my $WEDNESDAY = 3;
my $THURSDAY  = 4;
my $FRIDAY    = 5;
my $SATURDAY  = 6;

#
# Given a year, return its "Doomsday" value. 
# 0 -> Sunday, 6 -> Saturday
#
sub doomsday ($year) {
    use integer;
    my $anchor   = ($TUESDAY, $SUNDAY, $FRIDAY, $WEDNESDAY) [($year / 100) % 4];
    my $y        = $year % 100;
    my $doomsday = ((($y / 12) + ($y % 12) + (($y % 12) / 4)) + $anchor) % 7;
    $doomsday;
}

sub is_leap ($year) {
    ($year % 400 == 0) || ($year % 4 == 0) && ($year % 100 != 0)
}

foreach my $year (1900 .. 2100) {
    #
    # Get the Doomsday value; this is the day of the week of December 12.
    # Add 31, subtract 12 to get the day of the week of Dec 31. 
    #
    my $doomsday = doomsday ($year);
    my $dec_31   = ($doomsday - 12 + 31) % 7;
    say $year if $dec_31 == $THURSDAY || $dec_31 == $FRIDAY && is_leap $year;
}
