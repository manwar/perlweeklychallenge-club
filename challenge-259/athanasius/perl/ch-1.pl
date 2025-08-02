#!perl

################################################################################
=comment

Perl Weekly Challenge 259
=========================

TASK #1
-------
*Banking Day Offset*

Submitted by: Lee Johnson

You are given a start date and offset counter. Optionally you also get bank
holiday date list.

Given a number (of days) and a start date, return the number (of days) adjusted
to take into account non-banking days. In other words: convert a banking day
offset to a calendar day offset.

Non-banking days are:

 a) Weekends
 b) Bank holidays

Example 1

 Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
 Output: '2018-07-04'

 Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)

Example 2

 Input: $start_date = '2018-06-28', $offset = 3
 Output: '2018-07-03'

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Offsets are non-negative.
2. If the start date is a non-banking day, offset 0 is the first banking day
   after the start date.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The first command-line argument is a starting date, represented by a string
   in the format "YYYY-MM-DD" (ISO 8601).
3. The second command-line argument is an unsigned integer offset.
4. The third command-line argument is optional. If present, it is a string com-
   prising "YYYY-MM-DD" strings representing the dates of bank holidays. These
   date strings are separated by whitespace and/or commas.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use DateTime;
use List::Util     qw( none );
use Regexp::Common qw( number );
use Test::More;
use Try::Tiny;

const my $SATURDAY => 6;
const my $USAGE    => <<END;
Usage:
  perl $0 <start-date> <offset> [<bank-holidays>]
  perl $0

    <start-date>         Start date in 'YYYY-MM-DD' format
    <offset>             Non-negative offset in days
    [<bank-holidays>]    Optional string: list of bank holiday dates
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 259, Task #1: Banking Day Offset (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        error( 'Expected 0, 2, or 3 command-line arguments, found 1' );
    }
    elsif (2 <= $argc <= 3)
    {
        command_line_main();
    }
    else
    {
        error( "Expected 0, 2, or 3 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub command_line_main
#-------------------------------------------------------------------------------
{
    my ($start_date, $offset, $bank_holidays) = @ARGV;
    my  @holiday_strs;

    if (defined $bank_holidays)
    {
        @holiday_strs = split / [,\s]+ /x, $bank_holidays;

        printf "Input:  \$start_date    =  '$start_date'\n" .
               "        \$offset        =   $offset\n"      .
               "        \@bank_holidays = [%s]\n\n",
               join ', ', map { "'$_'" } @holiday_strs;
    }
    else
    {
        print  "Input:  \$start_date = '$start_date'\n"     .
               "        \$offset     =  $offset\n\n";
    }

    my ($start, $holiday_dates) =
               parse_command_line( $start_date, $offset, $bank_holidays );

    my  $day = find_banking_day( $start, $offset, $holiday_dates );

    printf "Output: '%s'\n", $day->ymd;
}

#-------------------------------------------------------------------------------
sub find_banking_day
#-------------------------------------------------------------------------------
{
    my ($start_date, $offset, $bank_holidays) = @_;

    my $day = $start_date;

    # 1. Advance, if necessary, to the first banking day ("day zero")

    $day->add( days => 1 ) until is_banking_day( $day, $bank_holidays );

    # 2. Advance (a further) $offset number of banking days

    for (my $count = $offset; $count > 0;)
    {
        --$count if is_banking_day( $day->add( days => 1 ), $bank_holidays );
    }

    return $day;
}

#-------------------------------------------------------------------------------
sub is_banking_day
#-------------------------------------------------------------------------------
{
    my ($date, $bank_holidays) = @_;

    return $date->day_of_week < $SATURDAY &&                # Monday to Friday
           none { $_->ymd eq $date->ymd } @$bank_holidays;  # Not a bank holiday
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($start_date_str, $offset, $bank_holidays) = @_;

    my  $start_date = parse_date( $start_date_str );

    $offset =~ / ^ $RE{num}{int} $ /x
                 or error( qq["$offset" is not a valid integer] );

    $offset >= 0 or error( 'Offset is negative' );

    my @holidays;

    for (split / [,\s]+ /x, $bank_holidays // '')
    {
        push @holidays, parse_date( $_ );
    }

    return ($start_date, \@holidays);
}

#-------------------------------------------------------------------------------
sub parse_date
#-------------------------------------------------------------------------------
{
    my ($date_str) = @_;
    my  $date;

    $date_str =~ / ^ (\d{4}) - (\d{2}) - (\d{2}) $ /x
        or error( qq[Invalid date string "$date_str"] );

    try
    {
        $date = DateTime->new( year => $1, month => $2, day => $3 );
    }
    catch
    {
        error( qq[Date validation failed for "$date_str"] );
    };                              # <-- The semicolon is required by Try::Tiny

    return $date;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $start_str, $offset, $holidays_str, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $start_str, $offset, $holidays_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($start, $holidays) =
            parse_command_line( $start_str, $offset, $holidays_str );

        my  $day      = find_banking_day( $start, $offset, $holidays );
        my  $expected = parse_date( $expected_str );

        is $day, $expected, $test_name;
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
Example 1    |2018-06-28|3|2018-07-03           |2018-07-04
Example 2    |2018-06-28|3|                     |2018-07-03
2 holidays   |2018-06-28|3|2018-07-03 2018-07-04|2018-07-05
Zero offset 1|2018-06-28|0|                     |2018-06-28
Zero offset 2|2018-06-28|0|2018-06-28           |2018-06-29
Zero offset 3|2018-06-30|0|                     |2018-07-02
Weekend start|2018-06-30|1|                     |2018-07-03
Holiday start|2018-06-28|1|2018-06-28           |2018-07-02
