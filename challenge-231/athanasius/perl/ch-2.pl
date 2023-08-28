#!perl

################################################################################
=comment

Perl Weekly Challenge 231
=========================

TASK #2
-------
*Senior Citizens*

Submitted by: Mohammad S Anwar

You are given a list of passenger details in the form “9999999999A1122”, where 9
denotes the phone number, A the sex, 1 the age and 2 the seat number.

Write a script to return the count of all senior citizens (age >= 60).

Example 1

  Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")
  Output: 2

  The age of the passengers in the given list are 75, 92 and 40.
  So we have only 2 senior citizens.

Example 2

  Input: @list = ("1313579440F2036","2921522980M5644")
  Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
An invalid passenger-detail string should generate a warning, but otherwise be
ignored.

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

use enum qw( VALID PHONE SEX AGE SEAT );

const my $SENIOR_AGE => 60;
const my $STRING_LEN => length '9999999999A1122';
const my $USAGE      =>
"Usage:
  perl $0 [<string> ...]
  perl $0

    [<string> ...]    A non-empty list of passenger-detail strings\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 231, Task #2: Senior Citizens (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        printf "Input:  \@list = (%s)\n", join ',', map { qq["$_"] } @ARGV;

        printf "Output: %d\n", count_seniors( \@ARGV );
    }
}

#-------------------------------------------------------------------------------
sub count_seniors
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  $count = 0;

    for my $str (@$list)
    {
        my  $details = parse_passenger_details( $str );

        if ($details->[ VALID ])
        {
            ++$count if $details->[ AGE ] >= $SENIOR_AGE;
        }
        else
        {
            print qq[WARNING: Ignoring invalid passenger information "$str"\n];
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub parse_passenger_details
#-------------------------------------------------------------------------------
{
    my ($string) = @_;
    #             VALID? PHONE  SEX    AGE    SEAT
    my  @details = (0,   undef, undef, undef, undef);

    if (length $string == $STRING_LEN)
    {
        my $phone = substr $string, 0, 10;

        if ($phone =~ / ^ \d{10} $ /x)
        {
            $details[ PHONE ] = $phone;
            my $sex           = substr $string, 10, 1;

            if ($sex =~ / ^ [MF] $ /x)
            {
                $details[ SEX ] = $sex;
                my $age         = substr $string, 11, 2;

                if ($age =~ / ^ \d{2} $ /x)
                {
                    $details[ AGE ] = $age;
                    my $seat        = substr $string, 13, 2;

                    if ($seat =~ / ^ \d{2} $ /x)
                    {
                        @details[ VALID, SEAT ] = (1, $seat);
                    }
                }
            }
        }
    }

    return \@details;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $passenger_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $passenger_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @list  = split / \s+ /x, $passenger_str;
        my $count = count_seniors( \@list );

        is $count, $exp_str, $test_name;
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
Example 1   |7868190130M7522 5303914400F9211 9273338290F4010|2
Example 2   |1313579440F2036 2921522980M5644                |0
Similar ages|5551234567M5901 5557654321F6002 5551928374M6103|2
