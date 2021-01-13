#! /opt/local/bin/perl
#
#       palindrome_dates.pl
#
#       PWC 48 - TASK #2
#         Palindrome Dates
#         Write a script to print all Palindrome Dates between 2000 and 2999.
#         The format of date is mmddyyyy. For example, the first one was on
#         October 2, 2001 as it is represented as 10022001.
#
#         method: constructing a list of palindrome candidates is in itself
#             little problem, merely reverse the year as a string and prepend
#             it. The primary challenge is evaluating whether this candidate can
#             be viewed as a valid mmddyyyy date. This is ascertained by
#             limiting 0 < m < 13 and that the day falls within the span of a
#             given month, determined by a lookup.
#
#             Leap years need not be considered as the date 02-29 reverses to
#             9220, which when considered as a year is outside the 2000-2999
#             range specified. We can see the largest possible day in our given
#             span will be the 22nd of any month, as any year past 2299 will
#             produce a date of the 32nd of the month and be invalid. In fact,
#             the only valid days in the range are the 2nd, the 12th, and the
#             22nd, corresponding to the century components 20xx, 21xx and 22xx.
#             All 12 months can be formed by the years after the centuries;
#             combining 12 months and 3 possible days = 36 results, which is
#             what is observed.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN


## palindrome date format is m1m2d1d2y1y2y3y4 <-/-> y4y3y2y1d2d1m2m1
for ( 2000..2999 ) {
    my $pal = (reverse $_) . $_;
    if ( validate($pal) ) {
        substr($pal, $_, 0, "-") for (2,5);
        say $pal;
    }
}

## ## ## ## ## SUBS

sub validate {
## returns true is the given string represents a valid mmddyyyy date
## does not consider leap years, code checks removed
    my $test = shift;
    my @mlen  = ( 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

    my ($m, $d) = map {substr($test, $_, 2)} (0, 2);

    return 0 if ( $m > 12           || $m == 0 );
    return 0 if ( $d > $mlen[$m-1]  || $d == 0 );
    return 1;

}
