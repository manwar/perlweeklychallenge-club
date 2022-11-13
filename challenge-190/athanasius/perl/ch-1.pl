#!perl

###############################################################################
=comment

Perl Weekly Challenge 190
=========================

TASK #1
-------
*Capital Detection*

Submitted by: Mohammad S Anwar

You are given a string with alphabetic characters only: A..Z and a..z.

Write a script to find out if the usage of Capital is appropriate if it satis-
fies at least one of the following rules:

  1) Only first letter is capital and all others are small.
  2) Every letter is small.
  3) Every letter is capital.

Example 1

  Input: $s = 'Perl'
  Output: 1

Example 2

  Input: $s = 'TPF'
  Output: 1

Example 3

  Input: $s = 'PyThon'
  Output: 0

Example 4

  Input: $s = 'raku'
  Output: 1

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

Observation
-----------
A single-letter string always satisfies either requirement 2 or requirement 3.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $TEST_FIELDS => 3;
const my $USAGE       =>
"Usage:
  perl $0 <s>
  perl $0

    <s>    A non-empty string of alphabetic characters (A-Z and a-z) only\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 190, Task #1: Capital Detection (Perl)\n\n";
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
        my $s = parse_command_line();

        print  "Input:  \$s = '$s'\n";
        printf "Output: %d\n", capitals_are_valid( $s );
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub capitals_are_valid
#------------------------------------------------------------------------------
{
    my ($s) = @_;

    return 1 if length( $s ) == 1;

    return 1 if $s =~ / ^ [a-z]+ $ /x ||      # 2) Every letter is small
                $s =~ / ^ [A-Z]+ $ /x;        # 3) Every letter is capital

    my $first = substr $s, 0, 1;
    my $rest  = substr $s, 1;

    return 1 if $first =~ / ^ [A-Z]  $ /x &&  # 1) Only first letter is capital
                $rest  =~ / ^ [a-z]* $ /x;    #    and all others are small

    return 0;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my ($s) = @ARGV;

    length $s > 0
        or  error( 'The input string is empty' );

    $s =~ / ([^A-Za-z]) /x
        and error( qq[Invalid character "$1" in \$s] );

    return $s;
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

        my ($test_name, $s, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        is capitals_are_valid( $s ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1, Perl,   1
Example 2, TPF,    1
Example 3, PyThon, 0
Example 4, raku,   1
Single,    X,      1
