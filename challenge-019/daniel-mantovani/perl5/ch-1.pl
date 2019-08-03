# Write a script to display months from the year 1900 to 2019 where
# you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

use strict;
use warnings;

# We start by noting that in order to have 3 weekday with 5
# ocurrences, the month should have 31 days.
# This is because, as a minimum, you will need:
#
# 3 weekdays * 5 repetitions = 15 days
# 4 weekdays * 4 repetitions = 16 days
#                              -------
# Total days                   31 days
#
# and as there are no month longer than that, our
# month will have to be exactly 31 days long
#
# But not every 31 day month will have 3 weekends. Let's see
# for example:
#
# Aug 2019
#
#   S  M  T  W  T  F  S
#               1  2  3
#   4  5  6  7  8  9 10
#  11 12 13 14 15 16 17
#  18 19 20 21 22 23 24
#  25 26 27 28 29 30 31
#
#   ^           ^  ^  ^
#   |           |  |  |____ 5 Saturdays ☑️
#   |           |  |_______ 5 Fridays ☑️
#   |           |__________ 5 Thursdays 🤷🏻‍♂️
#   |______________________ but only 4 Sundays 😖
#
# Looking at this example, it should be clear that
# the 2nd requisite to have 5 weekends is that 1st
# of month be a Friday
#
# Of course we could use an advanced module to ease
# day / month calculations, like DateTime (which by the
# way is the Kensho-recommended one), but it will probably
# not be that challenging to do so.
#
# Instead we are going to reuse many concepts from challenge-013-1,
# and just use the core Time::Local module to calculate first day
# epoch value.
# We will always use GMT/UTC variant for epoch calculations, just
# to be consistent.
#

use Time::Local;

my $epoch = timegm( 0, 0, 12, 1, 0, 1900 );    # January 1st 1900, 12 noon epoch
my $oneday = 24 * 3600;                        # one day in seconds

#
# Now we start calculating month by month, checking if it
# is a 31 day month, and also if 1st day of the month
# is a Friday
#

while ( ( gmtime($epoch) )[5] <= 119 ) {

    # note that gmtime's [5] response position is year minus 1900,
    # so we are just asking if $epoch correspond to a year less or
    # equal to 2019 to stay in the while loop
    #
    # first we calculate the 1st day of next month.
    # to do that, note that $epoch + 40 * $oneday will fall into next
    # month for sure. Then substracting the amount of new day of the
    # month and adding one we are for sure on the 1st day of the next
    # month

    my $next_month_epoch = $epoch + 40 * $oneday;
    $next_month_epoch -= ( ( gmtime($next_month_epoch) )[3] - 1 ) * $oneday;

   # so if for example $next_month_epoch corresponds to day 7, it will substract
   # 6 whole days, so $next_month_epoch will be corrected to represent
   # day 1 of next month

    # now we check if $epoch is a Friday, and if last day of current
    # month is 31

    if (   ( gmtime($epoch) )[6] == 5
        && ( gmtime( $next_month_epoch - $oneday ) )[3] == 31 )
    {
        # found a match. Just adjust gmtime's result to properly
        # show month and year, and then print the result
        my ( $month, $year ) = ( gmtime($epoch) )[ 4, 5 ];
        printf "Found 5 weekend month: %u/%u\n", $month + 1, $year + 1900;
    }

    # now we just repeat the loop with next month epoch
    $epoch = $next_month_epoch;
}
