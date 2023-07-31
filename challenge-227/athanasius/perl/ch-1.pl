#!perl

################################################################################
=comment

Perl Weekly Challenge 227
=========================

TASK #1
-------
*Friday 13th*

Submitted by: Peter Campbell Smith

You are given a year number in the range 1753 to 9999.

Write a script to find out how many dates in the year are Friday 13th, assume
that the current Gregorian calendar applies.

Example

  Input: $year = 2023
  Output: 2

  Since there are only 2 Friday 13th in the given year 2023 i.e. 13th Jan and
  13th Oct.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the solution (the number of dates) is
   followed by a list of the months in the given year in which the 13th is a
   Friday.

Note
----
"Friday the 13th .... occurs when the 13th day of the month in the Gregorian
calendar falls on a Friday, which happens at least once every year but can occur
up to three times in the same year." --"Friday the 13th", Wikipedia

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use DateTime;
use Regexp::Common qw( number );
use Test::More;

const my $FRIDAY  => 5;       # DateTime::day_of_week() outputs 1-7, Monday is 1
const my $MIN     => 1753;    # First valid year
const my $MAX     => 9999;    # Last  valid year
const my $VERBOSE => 1;       # Output month names in addition to the count
const my $USAGE   =>
"Usage:
  perl $0 <year>
  perl $0

    <year>    A year in the range $MIN to $MAX\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 227, Task #1: Friday 13th (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $year = $ARGV[ 0 ];

        $year =~ / ^ $RE{num}{int} $ /x
                              or error( qq["$year" is not a valid integer] );
        $MIN <= $year <= $MAX or error( qq["$year" is out of range] );

        print "Input:  \$year = $year\n";

        my $list  = find_friday_13th( $year );
        my $count = scalar @$list;

        print "Output: $count\n";

        if ($VERBOSE)
        {
            printf "\nMonth%s in %d in which 13th falls on a Friday: %s\n",
                    $count == 1 ? '' : 's', $year, join ', ', @$list;
        }
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $args" );
    }
}

#-------------------------------------------------------------------------------
sub find_friday_13th
#-------------------------------------------------------------------------------
{
    my ($year) = @_;
    my  @list;

    for my $month (1 .. 12)
    {
        my $dt  = DateTime->new( year => $year, month => $month, day => 13 );
        my $dow = $dt->day_of_week;

        push @list, $dt->month_abbr if $dow == $FRIDAY;
    }

    return \@list;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test, $year, $exp_count, $exp_list_str) = split / \| /x, $line;

        for ($test, $year, $exp_count, $exp_list_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @exp_list = split / \s+ /x, $exp_list_str;
        my $list     = find_friday_13th( $year );
        my $count    = scalar @$list;

        is        $count, $exp_count, "$test: count";
        is_deeply $list, \@exp_list,  "$test: months";
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example    |2023|2|Jan Oct
Wikipedia 1|2015|3|Feb Mar Nov
Wikipedia 2|1960|1|May
Wikipedia 3|1900|2|Apr Jul
Wikipedia 4|2099|3|Feb Mar Nov
