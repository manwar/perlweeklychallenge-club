#!perl

################################################################################
=comment

Perl Weekly Challenge 254
=========================

TASK #1
-------
*Three Power*

Submitted by: Mohammad S Anwar

You are given a positive integer, $n.

Write a script to return true if the given integer is a power of three otherwise
return false.

Example 1

  Input: $n = 27
  Output: true

  27 = 3 ^ 3

Example 2

  Input: $n = 0
  Output: true

  0 = 0 ^ 3

Example 3

  Input: $n = 6
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <n>
  perl $0

    <n>    A positive integer
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 254, Task #1: Three Power (Perl)\n\n";
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
        my $n = $ARGV[ 0 ];

        $n =~ / ^ $RE{num}{int} $ /x
                or error( qq["$n" is not a valid integer] );

        $n >= 0 or error( qq["$n" is not positive] );

        print  "Input:  \$n = $n\n";

        printf "Output: %s\n", is_three_power( $n ) ? 'true' : 'false';
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub is_three_power
#-------------------------------------------------------------------------------
{
    my ($n) = @_;

    my $cube_root = int( ($n ** (1 / 3)) + 0.5 );

    return $cube_root * $cube_root * $cube_root == $n;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $n, $expected) = split / \| /x, $line;

        for ($test_name, $n, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $result = is_three_power( $n ) ? 'true' : 'false';

        is $result, $expected, $test_name;
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
Example 1  |     27|true
Example 2  |      0|true
Example 3  |      6|false
Large power|1030301|true
One under  |1030300|false
One over   |1030302|false
