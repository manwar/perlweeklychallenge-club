#! /opt/local/bin/perl
#
#        sunday_xmas.pl
#
#        Task #1
#             Write a script to list dates for Sunday Christmas between 2019 and 2100. For
#             example, 25 Dec 2022 is Sunday.
#
#         methods:
#            The creation of algorithms to calculate the day of the week as a mathematical excursion
#            long predates any computer science. As such, there had been much work to draw on for this task.
#            In the simplest way, there are numerous date/time modules available that when given a date will simply spit out the
#            day of the week if asked. My preferred goto here is Date::Manip::Date and we start with that, looping through the years
#            2019-2100 and checking December 25 to see whether it's a Sunday and noting if it is.
#
#            A core strength of perl is that no matter what you may want to do, odd are someone somewhere has likely wished at some time
#            to do something similar, and that code is available on CPAN. Such reuse should never be considered "cheating" and
#            by all rights we have solved the task and should move on. But that's a bit boring and it's still only Monday.
#
#            Instead we'll avoid letting a module do the work for us and look at the algorithms themselves
#
#            I implement three algoritms, that basically work the same way, differing in how they create a series of monthly
#            offsets. I liked Tomohiko Sakamoto encoding the series in a character string the best, which makes a lot more sense
#            to do in C than Perl, but a map serves us well here.
#
#            each method is annotated in the subroutine.
#
#        results:
#             Xmas day 2024 is a Sunday
#             Xmas day 2029 is a Sunday
#             Xmas day 2035 is a Sunday
#             Xmas day 2046 is a Sunday
#             Xmas day 2052 is a Sunday
#             Xmas day 2057 is a Sunday
#             Xmas day 2063 is a Sunday
#             Xmas day 2074 is a Sunday
#             Xmas day 2080 is a Sunday
#             Xmas day 2085 is a Sunday
#             Xmas day 2091 is a Sunday
#
#        colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use Date::Manip::Date;


use warnings;
use strict;
use feature ":5.26";

use POSIX qw( floor );                ## to translate Gauss as exactly as possible

## ## ## ## ## MAIN

my %decode  =  (0 => 'Sunday',
                1 => 'Monday',
                2 => 'Tuesday',
                3 => 'Wednesday',
                4 => 'Thursday',
                5 => 'Friday',
                6 => 'Saturday' ) ;
my $day = 25;
my $month = 2;

for my $year ( 2019..2100 ) {

    ## these all work and produce the same result
    my $dm_dow = date_manip($year, $month, $day);
    my $nl_dow = gauss_nolookup($year, $month, $day);
    my $sa_dow = sakamoto($year, $month, $day);
    my $kc_dow = keith_craver($year, $month, $day);

    if ($sa_dow == 0) {
        say "Xmas day $year is a Sunday";
    }

}

## METHOD 1:
## using Date::Manip
## Date::Manip returns a numeric value 1 = Monday .. 7 = Sunday so we mod 7 to make it 0..6
## just to make our methods consistant

sub date_manip {
    my ($year, $month, $day) = @_;
    my $date = new Date::Manip::Date;
    $date->parse("$year/$month/$day");
    return ($date->printf("%w")) % 7;
}


## METHOD 2:
## variant of Gauss's algorithm,
## using an algebraic function to create a series of monthly offsets:
##        [2 5 0 3 5 1 4 6 2 4 0 3]
## instead of a lookup table, for the formula:
##         w = ( d + floor(2.6m-0.2) + yy + floor(yy/4) + floor(c/4) - 2c) % 7
##
## returns a numeric value 0 = Sunday .. 6 = Saturday

sub gauss_nolookup {
    my ($year, $month, $day) = @_;
    $year -= 1 if ($month < 3);
    my $m = ( ($month + 9) % 12 ) + 1;        ## shifted month, jan = 11, feb = 12, mar = 1 .. dec = 10
                                            ##         we need to first subtract and then later add 1 again to get it
                                            ##         to count from 1..12 instead of 0.11
    my $yy = $year % 100;                    ## two digit year
    my $century = floor( $year / 100 );
    return ( $day + floor((2.6 * $m) - 0.2) + $yy + floor($yy/4) + floor($century/4) - (2 * $century) ) % 7;
}


## METHOD 3:
## a function posted by
## Tomohiko Sakamoto on the usenet newsgroup comp.lang.c  12/14/92:

        # Please try this:
        # /*
        #  * 1 <= m <= 12,  y > 1752 (in the U.K.)
        #  */
        # dayofweek(y, m, d)
        # {
        #        y -= m < 3;
        #        return (y + y/4 - y/100 + y/400 + "-bed=pen+mad."[m] + d) % 7;
        # }
        #
        # --
        # T. Sakamoto

## note that "-bed=pen+mad."[m] indexes the char* to pull out a char as an ascii int, mod 7 this creates the series of monthly offsets
##        [ 3 0 3 2 5 0 3 5 1 4 6 2 4 ]
## in perl this would be:
##        map {ord($_)%7} (split //, "-bed=pen+mad.")
## which makes the array
##        [ 3, 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 ]
## which you may notice has 13 indices! But that was his algorithm as written.
## To stay with Sakamoto we leave the modulo operation until the end.
##
## returns a numeric value 0 = Sunday .. 6 = Saturday

sub sakamoto {
    my ($year, $month, $day) = @_;
    $year -= 1 if ($month < 3);
    return ($year + int($year/4) - int($year/100) + int($year/400) + ( map {ord($_)} (split //, "-bed=pen+mad.") )[$month] + $day) % 7;
}

## Method #4:
## Michael Keith and Tom Craver (1990)
# (d+=m<3?y--:y-2,23*m/9+d+4+y/4-y/100+y/400)%7
##
## returns a numeric value 0 = Sunday .. 6 = Saturday

sub keith_craver {
    my ($year, $month, $day) = @_;
    $day += ($month < 3) ? $year-- : $year - 2;
    return ( int( 23*$month/9 ) + $day + 4 + int( $year/4 ) - int( $year/100 ) + int( $year/400 ) ) % 7;
}
