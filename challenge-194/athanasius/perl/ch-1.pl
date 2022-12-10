#!perl

###############################################################################
=comment

Perl Weekly Challenge 194
=========================

TASK #1
-------
*Digital Clock*

Submitted by: Mohammad S Anwar

You are given time in the format hh:mm with one missing digit.

Write a script to find the highest digit between 0-9 that makes it valid time.

Example 1

  Input: $time = '?5:00'
  Output: 1

  Since 05:00 and 15:00 are valid time and no other digits can fit in the
  missing place.

Example 2

  Input: $time = '?3:00'
  Output: 2

Example 3

  Input: $time = '1?:00'
  Output: 9

Example 4

  Input: $time = '2?:00'
  Output: 3

Example 5

  Input: $time = '12:?5'
  Output: 5

Example 6

  Input: $time = '12:5?'
  Output: 9

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Algorithm
---------
Let the input be symbolized "wx:yz". There are 4 positions in which a digit can
be replaced by a question mark; each of these positions is treated as a sepa-
rate case:

  1. ?x:yz - if x is 0, 1, 2, or 3, then the highest value of w is 2; other-
             wise, it is 1.
  2. w?:yz - if w is 2, then the highest value of x is 3; otherwise, it is 9.
  3. wx:?z - the highest possible value of y is always 5.
  4. wx:y? - the highest possible value of z is always 9.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $TST_FLDS => 3;
const my $USAGE    =>
qq[Usage:
  perl $0 <time>
  perl $0

    <time>    Time in the format "hh:mm" with one digit replaced by "?"\n];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 194, Task #1: Digital Clock (Perl)\n\n";
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
    elsif ($args == 1)
    {
        my $time = parse_command_line();

        print  "Input:  \$time = '$time'\n";
        printf "Output: %s\n", find_highest_digit( $time );
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub find_highest_digit
#------------------------------------------------------------------------------
{
    my ($time)       = @_;
    my  $hour_orig   = substr $time, 0, 2;
    my  $hour_new    = $hour_orig;
    my  $minute_orig = substr $time, 3, 2;
    my  $minute_new  = $minute_orig;
    my  $digit;

    if    ($hour_orig   =~ / ^ \? (\d) $ /x)                     # Hour:   tens
    {
        substr( $hour_new,   0, 1 ) = $digit = ($1 < 4) ? 2 : 1;
    }
    elsif ($hour_orig   =~ / ^ (\d) \? $ /x)                     # Hour:   ones
    {
        substr( $hour_new,   1, 1 ) = $digit = ($1 < 2) ? 9 : 3;
    }
    elsif ($minute_orig =~ / ^ \? /x)                            # Minute: tens
    {
        substr( $minute_new, 0, 1 ) = $digit = 5;
    }
    else                                                         # Minute: ones
    {
        substr( $minute_new, 1, 1 ) = $digit = 9;
    }

    0 <= $hour_new   < 24 or error( qq[Invalid hour "$hour_orig"]     );
    0 <= $minute_new < 60 or error( qq[Invalid minute "$minute_orig"] );

    return $digit;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $time = $ARGV[ 0 ];

    length( $time ) == 5
        or error( 'The input string must be 5 characters long' );

    substr( $time, 2, 1 ) eq ':'
        or error( 'Hours and minutes must be separated by a colon' );

    my $count = 0;

    for my $i (0, 1, 3, 4)
    {
        my $c = substr $time, $i, 1;

        $c =~ /([^0-9?])/
            and error( qq[Invalid character "$1"] );

        ++$count if $c eq '?';
    }

    $count == 1
        or error( 'The input string must contain exactly one question mark' );

    return $time;
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

        my ($test_name, $n, $expected) = split / , \s* /x, $line, $TST_FLDS;

        is find_highest_digit( $n ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1, ?5:00, 1
Example 2, ?3:00, 2
Example 3, 1?:00, 9
Example 4, 2?:00, 3
Example 5, 12:?5, 5
Example 6, 12:5?, 9
