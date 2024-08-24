#!perl

################################################################################
=comment

Perl Weekly Challenge 283
=========================

TASK #2
-------
*Digit Count Value*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return true if for every index i in the range 0 <= i < size of
array, the digit i occurs exactly the $ints[$i] times in the given array other-
wise return false.

Example 1

  Input: @ints = (1, 2, 1, 0)
  Output: true

  $ints[0] = 1, the digit 0 occurs exactly 1 time.
  $ints[1] = 2, the digit 1 occurs exactly 2 times.
  $ints[2] = 1, the digit 2 occurs exactly 1 time.
  $ints[3] = 0, the digit 3 occurs 0 time.

Example 2

  Input: @ints = (0, 3, 0)
  Output: false

  $ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
  $ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
  $ints[2] = 0, the digit 2 occurs exactly 0 time.

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
2. A list of positive integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 283, Task #2: Digit Count Value (Perl)\n\n";
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
        my @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >= 0                or error( "$_ is negative");
            $_ += 0;                          # Normalize (e.g., change +1 to 1)
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $match = indices_match_freqs( \@ints );

        printf "Output: %s\n", $match ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub indices_match_freqs
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %count;

    ++$count{ $_ } for @$ints;

    for my $i (0 .. $#$ints)
    {
        my $value = $ints->[ $i ];

        if ($value == 0)
        {
            return 0 if exists $count{ $i };
        }
        else
        {
            return 0 if $count{ $i } != $value;
        }
    }

    return 1;
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

        my @ints  = split / \s+ /x, $ints_str;
        my $match = indices_match_freqs( \@ints ) ? 'true' : 'false';

        is $match, $expected, $test_name;
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
Example 1|1 2 1 0|true
Example 2|0 3 0  |false
