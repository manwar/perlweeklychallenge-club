#!perl

################################################################################
=comment

Perl Weekly Challenge 030
=========================

Task #1
-------
Write a script to list dates for Sunday Christmas between 2019 and 2100. For
example, 25 Dec 2022 is Sunday.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use DateTime;

const my $START_YEAR    => 2019;
const my $END_YEAR      => 2100;
const my $DECEMBER      =>   12;
const my $CHRISTMAS_DAY =>   25;
const my $SUNDAY        =>    7;
const my $FORMAT        => 'Between %d and %d (inclusive), Christmas Day ' .
                           "(%dth December) falls on a\nSunday in %s, and %s\n";

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my @years;

    for my $year ($START_YEAR .. $END_YEAR)
    {
        my $date = DateTime->new
                   (
                       year  => $year,
                       month => $DECEMBER,
                       day   => $CHRISTMAS_DAY,
                   );

        push @years, $year if $date->day_of_week() == $SUNDAY;
    }

    my $final_year = pop @years;

    printf $FORMAT, $START_YEAR, $END_YEAR, $CHRISTMAS_DAY, join(', ', @years),
                    $final_year;
}

################################################################################
