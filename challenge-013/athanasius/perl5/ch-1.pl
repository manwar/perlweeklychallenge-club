#!perl

################################################################################
=comment

Perl Weekly Challenge 013
=========================

Challenge #1
------------

Write a script to print the date of last *Friday* of every month of a given
year. For example, if the given year is *2019* then it should print the follow-
ing:

2019/01/25
2019/02/22
2019/03/29
2019/04/26
2019/05/31
2019/06/28
2019/07/26
2019/08/30
2019/09/27
2019/10/25
2019/11/29
2019/12/27

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use DateTime;
use Regexp::Common;

const my @DAYS_IN_MONTH  => ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );
const my $DAYS_IN_WEEK   =>    7;
const my $DEFAULT_YEAR   => 2019;
const my $FEBRUARY_INDEX =>    1;
const my @OFFSET_1ST_FRI => (  4,  3,  2,  1,  0,  6,  5 );
const my $USAGE          => "USAGE: perl $0 <year>";

$| = 1;

MAIN:
{
    my $year  = get_year();
    my $dt    = DateTime->new(year => $year, month => 1, day => 1);
    my $first = 1 + $OFFSET_1ST_FRI[ $dt->day_of_week - 1 ];
    my @days  = @DAYS_IN_MONTH;
     ++$days[ $FEBRUARY_INDEX ] if $dt->is_leap_year();

    print "\nLast Fridays in each month of $year:\n\n";

    for my $month (0 .. 11)
    {
        my $days  = $days[ $month ];
        my $last  = $first;
           $last += $DAYS_IN_WEEK until $last > $days;
           $first = $last - $days;
           $last -= $DAYS_IN_WEEK;

        printf "%4d/%02d/%02d\n", $year, ($month + 1), $last;
    }
}

sub get_year
{
    scalar @ARGV <= 1
        or die "\n$USAGE\n";

    my $year = $ARGV[0] // $DEFAULT_YEAR;

    $year =~ /^$RE{num}{int}$/
        or die "\nInvalid year '$year': must be an integer\n";

    return $year;
}

################################################################################
