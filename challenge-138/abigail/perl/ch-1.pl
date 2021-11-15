#!/opt/perl/bin/perl

use 5.028;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# A year can have 260, 261 or 262 workdays. 
#
# Regular years start and end on the same day of the week. Which means
# that if Jan 1 is a workday, then Dec 31 is, and hence, the year has
# 261 workdays. If Jan 1 is a weekday, the year has 260 workdays.
#
# Leap years ends on a day which is one day later than the day of the
# week it starts on. So, if Jan 1 is Monday to Thursday, the year ends
# on a Tuesday to Friday, resulting in a year with 262 workdays. If the
# year starts on a Friday, it ends on a Saturday, giving 261 workdays.
# If the year starts on a Saturday, it ends on a Sunday, giving 260 workdays,
# and if the year starts on a Sunday, it ends on a Monday, giving 261
# workdays.
#
# So, we could make a lookup table, based on the day of the week of
# Jan 1, and whether the year is a leap day or not. But we won't. Since
# last weeks challenge made us calculate the Doomsday value of the year,
# we will make a lookup table based on that. The Doomsday value is the
# day of the week on Jan 3 (regular years), or Jan 4 (leap years).
#
# This gives us the following table:
#
#                   +-------+----------+-------+----------+
#                   |   Regular Year   |    Leap Year     |
#  +----------------+-------+----------+-------+----------+
#  | Doomsday value | Jan 1 | Workdays | Jan 1 | Workdays |
#  +----------------+-------+----------+-------+----------+
#  |              0 |  Fri  |      261 |   Thu |      262 |
#  |              1 |  Sat  |      260 |   Fri |      261 |
#  |              2 |  Sun  |      260 |   Sat |      260 |
#  |              3 |  Mon  |      261 |   Sun |      261 |
#  |              4 |  Tue  |      261 |   Mon |      262 |
#  |              5 |  Wed  |      261 |   Tue |      262 |
#  |              6 |  Thu  |      261 |   Wed |      262 |
#  +----------------+-------+----------+-------+----------+

my @lookup = (
    [261, 260, 260, 261, 261, 261, 261],   # Regular years
    [262, 261, 260, 261, 262, 262, 262],   # Leap years
);

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
sub doomsday ($year = $_) {
    use integer;
    my $anchor   = ($TUESDAY, $SUNDAY, $FRIDAY, $WEDNESDAY) [($year / 100) % 4];
    my $y        = $year % 100;
    my $doomsday = ((($y / 12) + ($y % 12) + (($y % 12) / 4)) + $anchor) % 7;
    $doomsday;
}

sub is_leap ($year = $_) {
    ($year % 400 == 0) || ($year % 4 == 0) && ($year % 100 != 0) ? 1 : 0
}


while (<>) {
    say $lookup [is_leap] [doomsday]
}
