#!perl

###############################################################################
=comment

Perl Weekly Challenge 193
=========================

TASK #1
-------
*Binary String*

Submitted by: Mohammad S Anwar

You are given an integer, $n > 0.

Write a script to find all possible binary numbers of size $n.

Example 1

  Input: $n = 2
  Output: 00, 11, 01, 10

Example 2

  Input: $n = 3
  Output: 000, 001, 010, 100, 111, 110, 101, 011

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FLDS => 3;
const my $USAGE     =>
"Usage:
  perl $0 <n>
  perl $0

    <n>    An integer greater than zero\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 193, Task #1: Binary String (Perl)\n\n";
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
                or error( qq["$n" is not a valid integer] );

        $n > 0  or error( qq["$n" is not positive] );

        print  "Input:  \$n = $n\n";
        printf "Output: %s\n", join ', ', @{ find_binary_numbers( $n ) };
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub find_binary_numbers
#------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  @binaries;

    for my $i (0 .. 2 ** $n - 1)
    {
        push @binaries, sprintf '%0*b', $n, $i;
    }

    return \@binaries;
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

        my ($test_name, $n, $expected) = split / , \s* /x, $line, $TEST_FLDS;
        my  @expected = sort split / \s+ /x, $expected;

        is_deeply( find_binary_numbers( $n ), \@expected, $test_name );
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1, 2, 00 11 01 10
Example 2, 3, 000 001 010 100 111 110 101 011
