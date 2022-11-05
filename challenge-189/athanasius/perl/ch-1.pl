#!perl

###############################################################################
=comment

Perl Weekly Challenge 189
=========================

TASK #1
-------
*Greater Character*

Submitted by: Mohammad S Anwar

You are given an array of characters (a..z) and a target character.

Write a script to find out the smallest character in the given array lexico-
graphically greater than the target character.

Example 1

  Input: @array = qw/e m u g/, $target = 'b'
  Output: e

Example 2

  Input: @array = qw/d c e f/, $target = 'a'
  Output: c

Example 3

  Input: @array = qw/j a r/, $target = 'o'
  Output: r

Example 4

  Input: @array = qw/d c a f/, $target = 'a'
  Output: c

Example 5

  Input: @array = qw/t g a l/, $target = 'v'
  Output: v

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

Note
----
From Example 5, it appears that when no characters in the input array satisfy
the given criteria, the target character is the expected output.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $HIGH_CHAR   => '~';    # Character lexicographically greater than 'z'
const my $TEST_FIELDS =>  4;
const my $USAGE       =>
"Usage:
  perl $0 <array> <target>
  perl $0

    <array>     A string of space-separated lowercase letters
    <target>    A target character (also 'a' .. 'z')\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 189, Task #1: Greater Character (Perl)\n\n";
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
        my ($array, $target) = parse_command_line();

        printf "Input:  \@array = qw/%s/, \$target = '%s'\n",
                join( ' ', @$array ), $target;

        printf "Output: '%s'\n", solve( $array, $target );
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub solve
#------------------------------------------------------------------------------
{
    my ($array, $target) = @_;
    my  $char = $HIGH_CHAR;

    for my $elem (@$array)
    {
        $char = $elem if $elem gt $target && $elem lt $char;
    }

    $char = $target if $char eq $HIGH_CHAR;

    return $char;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my ($array, $target) = @ARGV;
    my  @array           = split / \s+ /x, $array;

    for my $elem (@array)
    {
        $elem =~ / ^ [a-z] $ /x
            or error( qq[Array element "$elem" is not a lowercase letter] );
    }

    $target   =~ / ^ [a-z] $ /x
            or error( qq[Target "$target" is not a lowercase letter] );

    return (\@array, $target);
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

        my ($test_name, $array, $target, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        my @array = split / \s+ /x, $array;
        my $char  = solve( \@array, $target );

        is $char, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,   e m u g, b, e
Example 2,   d c e f, a, c
Example 3,   j a r,   o, r
Example 4,   d c a f, a, c
Example 5,   t g a l, v, v
Empty array, ,        q, q
