#!perl

###############################################################################
=comment

Perl Weekly Challenge 187
=========================

TASK #1
-------
*Days Together*

Submitted by: Mohammad S Anwar

Two friends, Foo and Bar gone on holidays seperately to the same city. You are
given their schedule i.e. start date and end date.

To keep the task simple, the date is in the form DD-MM and all dates belong to
the same calendar year i.e. between 01-01 and 31-12. Also the year is non-leap
year and both dates are inclusive.

Write a script to find out for the given schedule, how many days they spent
together in the city, if at all.

Example 1

  Input: Foo => SD: '12-01' ED: '20-01'
         Bar => SD: '15-01' ED: '18-01'

  Output: 4 days

Example 2

  Input: Foo => SD: '02-03' ED: '12-03'
         Bar => SD: '13-03' ED: '14-03'

  Output: 0 day

Example 3

  Input: Foo => SD: '02-03' ED: '12-03'
         Bar => SD: '11-03' ED: '15-03'

  Output: 2 days

Example 4

  Input: Foo => SD: '30-03' ED: '05-04'
         Bar => SD: '28-03' ED: '02-04'

  Output: 4 days

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If two arguments are given on the command-line, they are parsed as strings for-
matted according to the Examples in the Task description.

If eight arguments are given on the command-line, they are processed as four
pairs of integers, each pair representing a day-of-month together with its
associated month.

If no arguments are given on the command-line, the test suite is run.

Algorithm
---------
After some sanity checking by sub validate_date(), each of the four day/month
pairs is converted to a single day-of-the-year. For example, 04-03 (1st March)
is converted to Day 63 (= 31 + 28 + 4). This facilitates further sanity check-
ing followed by date comparison in sub count_days_together() to produce the
desired solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common;
use Test::More;

const my @DAY_OF_YEAR    =>
         (  0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 );
const my @DAYS_PER_MONTH =>
         ( 31, 28, 31, 30,  31,  30,  31,  31,  30,  31,  30,  31 );
const my @MONTH_NAMES    =>
       qw( January February March     April   May      June
           July    August   September October November December );
const my $TEST_FIELDS    => 3;
const my $USAGE          =>
qq{Usage:
  perl $0 <foo> <bar>
  perl $0 [<data> ...]
  perl $0

    <foo>           String of the form "Foo => SD: '12-01' ED: '20-01'"
    <bar>           String of the form "Bar => SD: '15-01' ED: '18-01'"
    [<data> ...]    8 integers (4 day/month pairs)\n};

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 187, Task #1: Days Together (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 2)
    {
        my ($foo, $bar) = @ARGV;
        my  @data;

        $foo =~ / ^ Foo \s => \s SD: \s ' (\d\d) - (\d\d) ' \s
                                 ED: \s ' (\d\d) - (\d\d) '  $ /x
            or error( 'Invalid input format for $foo' );

        push @data, @{ ^CAPTURE };

        $bar =~ / ^ Bar \s => \s SD: \s ' (\d\d) - (\d\d) ' \s
                                 ED: \s ' (\d\d) - (\d\d) '  $ /x
            or error( 'Invalid input format for $bar' );

        push @data, @{ ^CAPTURE };

        solve( \@data );
    }
    elsif ($args == 8)
    {
        solve( \@ARGV );
    }
    else
    {
        error( "Expected 0, 2, or 8 command-line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub solve
#------------------------------------------------------------------------------
{
    my ($data) = @_;

    for my $i (0, 2, 4, 6)
    {
        validate_date( $data->[ $i ], $data->[ $i + 1 ] );
    }

    printf "Input:  Foo => SD: '%02d-%02d' ED: '%02d-%02d'\n" .
           "        Bar => SD: '%02d-%02d' ED: '%02d-%02d'\n\n", @$data;

    my $days = count_days_together( $data );

    printf "Output: $days day%s\n", $days == 1 ? '' : 's';
}

#------------------------------------------------------------------------------
sub validate_date
#------------------------------------------------------------------------------
{
    my ($day, $month) = @_;

    $month =~ / ^ $RE{num}{int} $ /x
        or error( qq[Month "$month" is not a valid integer]);

    1 <= $month <= 12
        or error( qq{Invalid month "$month"} );

    $day   =~ / ^ $RE{num}{int} $ /x
        or error( qq[Day "$day" is not a valid integer]);

    1 <= $day <= $DAYS_PER_MONTH[ $month - 1 ]
        or error( sprintf qq{$day is not a valid day for %s},
                    $MONTH_NAMES[ $month - 1 ] );
}

#------------------------------------------------------------------------------
sub count_days_together
#------------------------------------------------------------------------------
{
    my ($data)  = @_;
    my  $foo_sd = $DAY_OF_YEAR[ $data->[ 1 ] - 1 ] + $data->[ 0 ];
    my  $foo_ed = $DAY_OF_YEAR[ $data->[ 3 ] - 1 ] + $data->[ 2 ];
    my  $bar_sd = $DAY_OF_YEAR[ $data->[ 5 ] - 1 ] + $data->[ 4 ];
    my  $bar_ed = $DAY_OF_YEAR[ $data->[ 7 ] - 1 ] + $data->[ 6 ];

    $foo_sd <= $foo_ed
        or error( 'Foo\'s holiday cannot end before it starts' );

    $bar_sd <= $bar_ed
        or error( 'Bar\'s holiday cannot end before it starts' );

    my $start = ($foo_sd >= $bar_sd) ? $foo_sd : $bar_sd;             # Maximum
    my $end   = ($foo_ed <= $bar_ed) ? $foo_ed : $bar_ed;             # Minimum
    my $diff  =  $end - $start;

    return $diff >= 0 ? $diff + 1 : 0;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        my  @data = split /\s+/, $input;

        is count_days_together( \@data ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,        12 01 20 01 15 01 18 01,   4
Example 2,        02 03 12 03 13 03 14 03,   0
Example 3,        02 03 12 03 11 03 15 03,   2
Example 4,        30 03 05 04 28 03 02 04,   4
Whole year,       01 01 31 12 01 01 31 12, 365
Smallest overlap, 15 01 22 02 22 02 17 03,   1
