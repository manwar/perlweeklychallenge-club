#!perl

################################################################################
=comment

Perl Weekly Challenge 326
=========================

TASK #1
-------
*Day of the Year*

Submitted by: Mohammad Sajid Anwar

You are given a date in the format YYYY-MM-DD.

Write a script to find day number of the year that the given date represent.

Example 1

  Input: $date = '2025-02-02'
  Output: 33

  The 2nd Feb, 2025 is the 33rd day of the year.

Example 2

  Input: $date = '2025-04-10'
  Output: 100

Example 3

  Input: $date = '2025-09-07'
  Output: 250

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A valid date in the format "YYYY-MM-DD" is entered on the command-line.

=cut
#===============================================================================

use v5.32;       # Enables strictures
use warnings;
use Const::Fast;
use DateTime;
use Syntax::Keyword::Try;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <date>
  perl $0

    <date>    A valid date in the format "YYYY-MM-DD"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 326, Task #1: Day of the Year (Perl)\n\n";
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
        my $date = $ARGV[ 0 ];

        print "Input:  \$date = '$date'\n";

        my $day_of_year = find_day_of_year( $date );

        print "Output: $day_of_year\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_day_of_year
#-------------------------------------------------------------------------------
{
    my ($date) =  @_;
        $date  =~ / ^ (\d{4}) - (\d\d) - (\d\d) $ /x
                     or error( 'Invalid date format' );

    my ($year, $month, $day) = ($1, $2, $3);

    0 < $month <= 12 or error( qq[Invalid month "$month"] );
    0 < $day   <= 31 or error( qq[Invalid day "$day"]     );

    my  $dt;

    try
    {
        $dt = DateTime->new( year => $year, month => $month, day => $day );
    }
    catch
    {
        my     $msg = $@ =~ s/ (\n .*) $ //rx;
        chomp  $msg;
        error( $msg );
    }

    return $dt->day_of_year;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $date, $expected) = split / \| /x, $line;

        for ($test_name, $date, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $day_of_year = find_day_of_year( $date );

        is $day_of_year, $expected, $test_name;
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
Example 1|2025-02-02| 33
Example 2|2025-04-10|100
Example 3|2025-09-07|250
