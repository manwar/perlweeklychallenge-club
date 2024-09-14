#!perl

################################################################################
=comment

Perl Weekly Challenge 286
=========================

TASK #2
-------
*Order Game*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, whose length is a power of 2.

Write a script to play the order game (min and max) and return the last element.

Example 1

  Input: @ints = (2, 1, 4, 5, 6, 3, 0, 2)
  Output: 1

  Operation 1:

      min(2, 1) = 1
      max(4, 5) = 5
      min(6, 3) = 3
      max(0, 2) = 2

  Operation 2:

      min(1, 5) = 1
      max(3, 2) = 3

  Operation 3:

      min(1, 3) = 1

Example 2

  Input: @ints = (0, 5, 3, 2)
  Output: 0

  Operation 1:

      min(0, 5) = 0
      max(3, 2) = 3

  Operation 2:

      min(0, 3) = 0

Example 3

  Input: @ints = (9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8)
  Output: 2

  Operation 1:

      min(9, 2) = 2
      max(1, 4) = 4
      min(5, 6) = 5
      max(0, 7) = 7
      min(3, 1) = 1
      max(3, 5) = 5
      min(7, 9) = 7
      max(0, 8) = 8

  Operation 2:

      min(2, 4) = 2
      max(5, 7) = 7
      min(1, 5) = 1
      max(7, 8) = 8

  Operation 3:

      min(2, 7) = 2
      max(1, 8) = 8

  Operation 4:

      min(2, 8) = 2

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
2. A non-empty list of integers is entered on the command-line. The length of
   the list must be a power of two.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use List::Util     qw( max min );
use Regexp::Common qw( number );
use Test::More;

const my $LOG2  => log 2;
const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers whose length is a power of 2
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 286, Task #2: Order Game (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if ($argc == 0)
    {
        run_tests();
    }
    else
    {
        my $ints = parse_command_line();

        printf "Input:  \@ints = (%s)\n", join ', ', @$ints;

        my $last_element = play_order_game( $ints );

        print  "Output: $last_element\n";
    }
}

#-------------------------------------------------------------------------------
sub play_order_game
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    while (scalar @$ints > 1)
    {
        my ($lhs, $rhs, @temp);

        while (@$ints)
        {
            $lhs = shift @$ints;
            $rhs = shift @$ints;

            push @temp, min( $lhs, $rhs );

            if (@$ints)
            {
                $lhs = shift @$ints;
                $rhs = shift @$ints;

                push @temp, max( $lhs, $rhs );
            }
        }

        @$ints = @temp;
    }

    return $ints->[ 0 ];
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my @ints = @ARGV;

    for my $int (@ints)
    {
        $int =~ / ^ $RE{num}{int} $ /x
            or error( qq["$int" is not a valid integer] );
    }

    my $length = scalar @ints;
    my $log    = int( log( $length ) / $LOG2 + 0.5 );

    2 ** $log == $length
            or error( 'The length of the input list is not a power of 2' );

    return \@ints;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $last = play_order_game( \@ints );

        is $last, $expected, $test_name;
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
Example 1| 2 1  4 5 6 3 0 2                | 1
Example 2| 0 5  3 2                        | 0
Example 3| 9 2  1 4 5 6 0 7 3 1 3 5 7 9 0 8| 2
Singleton|42                               |42
Negatives|-9 0 -1 5                        |-9
