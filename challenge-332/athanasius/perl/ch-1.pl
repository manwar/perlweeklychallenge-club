#!perl

################################################################################
=comment

Perl Weekly Challenge 332
=========================

TASK #1
-------
*Binary Date*

Submitted by: Mohammad Sajid Anwar

You are given a date in the format YYYY-MM-DD.

Write a script to convert it into binary date.

Example 1

  Input: $date = "2025-07-26"
  Output: "11111101001-111-11010"

Example 2

  Input: $date = "2000-02-02"
  Output: "11111010000-10-10"

Example 3

  Input: $date = "2024-12-31"
  Output: "11111101000-1100-11111"

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

Assumption
----------
Dates must be valid.

=cut
#===============================================================================

use v5.32;        # Enables strictures
use warnings;
use Const::Fast;
use DateTime;
use Devel::Assert qw( on );
use Test::More;
use Try::Tiny;

const my $DATE_RE => qr/ ^ (\d{4}) \- (\d\d) \- (\d\d) $ /x;
const my $USAGE   => <<END;
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
    print "\nChallenge 332, Task #1: Binary Date (Perl)\n\n";
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

        date_is_valid( $date ) or error( 'Invalid date' );

        print qq[Input:  \$date = "$date"\n];

        my $bin_date = find_binary_date( $date );

        print qq[Output: "$bin_date"\n];
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_binary_date
#-------------------------------------------------------------------------------
{
    my ($date) = @_;

    assert date_is_valid( $date );

    $date =~ $DATE_RE;

    my $bin_year  = sprintf '%b', $1;
    my $bin_month = sprintf '%b', $2;
    my $bin_day   = sprintf '%b', $3;

    return "$bin_year-$bin_month-$bin_day";
}

#-------------------------------------------------------------------------------
sub date_is_valid                                      # Returns a boolean value
#-------------------------------------------------------------------------------
{
    my ($date)  = @_;
    my  $result = '';

    if ($date =~ $DATE_RE)
    {
        $result = 1;

        try
        {
            DateTime->new( year => $1, month => $2, day => $3 );
        }
        catch
        {
            $result = '';
        }
    }

    return $result;
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

        my $bin_date = find_binary_date( $date );

        is $bin_date, $expected, $test_name;
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
Example 1|2025-07-26|11111101001-111-11010
Example 2|2000-02-02|11111010000-10-10
Example 3|2024-12-31|11111101000-1100-11111
