#!perl

###############################################################################
=comment

Perl Weekly Challenge 198
=========================

TASK #2
-------
*Prime Count*

Submitted by: Mohammad S Anwar

You are given an integer $n > 0.

Write a script to print the count of primes less than $n.

Example 1

  Input: $n = 10
  Output: 4 as in there are 4 primes less than 10 are 2, 3, 5, 7.

Example 2

  Input: $n = 15
  Output: 6

Example 3

  Input: $n = 1
  Output: 0

Example 4

  Input: $n = 25
  Output: 9

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line argument is given, the test suite is run.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use ntheory        qw( prime_count );
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
const my $USAGE       =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    An integer greater than zero\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 198, Task #2: Prime Count (Perl)\n\n";
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
        my $n = $ARGV[ 0 ];

        $n =~ / ^ $RE{num}{int} $ /x
               or error( qq["$_" is not a valid integer] );

        $n > 0 or error( "$n is not greater than zero" );

        print  "Input:  \$n = $n\n";
        printf "Output: %d\n", count_primes( $n );
    }
    else
    {
        error( "Expected 1 or 0 command line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub count_primes
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    # Note: The count returned by Math::Prime::Util::prime_count( $x ) is
    #       *inclusive* of $x

    return prime_count( $n - 1 );
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

        my ($test_name, $n, $expected) = split / \| /x, $line, $TEST_FIELDS;

        s/ ^ \s* (.+?) \s* $ /$1/x                            # Trim whitespace
            for $test_name, $n, $expected;

        is count_primes( $n ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1|        10|       4
Example 2|        15|       6
Example 3|         1|       0
Example 4|        25|       9
Large n  |   1000000|   78498
Huge n   |1234567890|62106578
