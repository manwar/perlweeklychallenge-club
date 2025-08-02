#!perl

################################################################################
=comment

Perl Weekly Challenge 268
=========================

TASK #1
-------
*Magic Number*

Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers of same size, @x and @y.

Write a script to find the magic number that when added to each elements of one
of the array gives the second array. Elements order is not important.

Example 1

  Input: @x = (3, 7, 5)
         @y = (9, 5, 7)
  Output: 2

  The magic number is 2.
  @x = (3, 7, 5)
     +  2  2  2
  @y = (5, 9, 7)

Example 2

  Input: @x = (1, 2, 1)
         @y = (5, 4, 4)
  Output: 3

  The magic number is 3.
  @x = (1, 2, 1)
     +  3  3  3
  @y = (5, 4, 4)

Example 3

  Input: @x = (2)
         @y = (5)
  Output: 3

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input lists @x and @y are entered as two strings on the command-line:
   each string is a list of whitespace-separated integers.

Algorithm
---------
Assume there is a magic number m that satisfies the requirement that when m is
added to each element of @x it produces @y (ignoring element order). Let there
be n elements in each of @x and @y, and let the elements of @x be sorted in monotonically-ascending order as x1 <= x2 <= x3 <= ... <= xn. Likewise, let the
elements of @y be y1 <= y2 <= y3 <= ... <= yn.

Suppose that x1 + m = y2, and that y2 > y1. Then y1's counterpart in @x would be
x0 = y1 - m, and since y1 < y2, we have x0 < x1, which is impossible since x1 is
lowest in sort order. It follows that x1's counterpart in @y can only be y1 (or
another y equal to y1). So we can remove the pair (x1, y1) and apply the same
reasoning to the remaining elements of @x and @y recursively. We conclude that
if m exists, it must be the difference between corresponding elements of the two
ordered arrays. That is, x1 + m = y1, x2 + m = y2, ... xn + m = yn.

This leads to a straightforward algorithm:

    SUB find-magic-number
        Sort @x in increasing numerical order
        Sort @y in increasing numerical order
        m    := y1 - x1
        fail := False
        i    := 1
        WHILE not fail AND i <= n
            diff := yi - xi
            IF diff ≠ m
                fail := True
            ENDIF
            i := i + 1
        ENDWHILE
        IF fail
            m := undefined
        ENDIF
        RETURN m
    ENDSUB

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Devel::Assert  qw( on );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <x> <y>
  perl $0

    <x>    A list of integers separated by whitespace
    <y>    Another integer list of the same size
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 268, Task #1: Magic Number (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my ($x, $y) = parse_command_line();

        printf "Input:  \@x = (%s)\n", join ', ', @$x;
        printf "        \@y = (%s)\n", join ', ', @$y;

        my $magic = find_magic_number( $x, $y );

        printf "Output: %s\n", $magic // 'none';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_magic_number
#-------------------------------------------------------------------------------
{
    my ($x, $y) = @_;

    assert scalar @$x == scalar @$y;

    my @x_sorted = sort { $a <=> $b } @$x;
    my @y_sorted = sort { $a <=> $b } @$y;
    my $magic    = $y_sorted[ 0 ] - $x_sorted[ 0 ];

    for my $i (1 .. $#$x)
    {
        return unless $y_sorted[ $i ] - $x_sorted[ $i ] == $magic;
    }

    return $magic;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    assert scalar @ARGV == 2;

    for (@ARGV)
    {
        s/ ^ \s+   //x;
        s/   \s+ $ //x;
    }

    my @x_strs = split / \s+ /x, $ARGV[ 0 ];
    my @y_strs = split / \s+ /x, $ARGV[ 1 ];

    scalar @x_strs == scalar @y_strs
                               or error( '@x and @y are of different sizes' );

    my  (@x, @y);

    for (@x_strs)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        push @x, $_;
    }

    for (@y_strs)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        push @y, $_;
    }

    return \@x, \@y;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $x_str, $y_str, $expected) = split / \| /x, $line;

        for ($test_name, $x_str, $y_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @x     = split / \s+ /x, $x_str;
        my @y     = split / \s+ /x, $y_str;
        my $magic = find_magic_number( \@x, \@y );

        is $magic // 'none', $expected, $test_name;
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
Example 1 | 3  7  5| 9  5  7| 2
Example 2 | 1  2  1| 5  4  4| 3
Example 3 | 2      | 5      | 3
None      | 1  2   | 3  5   |none
Zero      | 1  2  3| 2  3  1| 0
Negative 1|-1 -3 -5|-3  1 -1| 2
Negative 2|-1 -3 -5|-8 -4 -6|-3
