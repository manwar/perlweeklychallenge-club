# Write a script to print the date of last Friday of every month of a given year.
# For example, if the given year is 2019 then it should print the following:
#
# 2019/01/25
# 2019/02/22
# 2019/03/29
# 2019/04/26
# 2019/05/31
# 2019/06/28
# 2019/07/26
# 2019/08/30
# 2019/09/27
# 2019/10/25
# 2019/11/29
# 2019/12/27

use strict;
use warnings;
use v5.10;

# To find last Friday of each month we will go to the next month
# first Friday and then back a whole week. First week of a month
# is easy to identify because "month day" of it will be 1 to 7.
#
# So we will go from first week of February to first week of
# January next year to get all values form corresponding
# previous week.
#
# We start by reading year value, and calculating epoch of
# first day of February at noon for that year.
#
# We are going to use the core Time::Local module for that,
# and we will always use GMT/UTC variant.

use Time::Local;
my $year   = shift;
my $epoch  = timegm( 0, 0, 12, 1, 1, $year );    # February 1st 12 noon epoch
my $oneday = 24 * 3600;                          # one day in seconds

# Now we start calculating month by month, incrementing
# $epoch by days or weeks to find each month first Friday.
#
# We are using only two values form the array returned by
# Perl standard function gmtime:
# (gmtime(<epoch>))[6] gives us the "week day" (5 for Friday), and
# (gmtime(<epoch>))[3] gives us the "month day" ( could be from 1
# to 31 depending on the actual month),

my $month = 1;

while ( $month <= 12 ) {
    if ( ( gmtime($epoch) )[6] != 5 ) {

        # not a Friday, try again tomorrow
        $epoch += $oneday;
    }
    elsif ( ( gmtime($epoch) )[3] > 7 ) {

        # not on first week, try again on next week
        $epoch += 7 * $oneday;
    }
    else {

        # here $epoch corresponds to the first Friday of the
        # following month to $month. So we already have
        # the year and the month, and only need to calculate
        # exact "month day" of last week's Friday
        printf "%4u/%02u/%2u\n", $year, $month++,
          ( gmtime( $epoch - 7 * $oneday ) )[3];

        # and we don't really need to check next 3 weeks
        $epoch += 28 * $oneday;
    }
}
