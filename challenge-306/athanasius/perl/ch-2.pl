#!perl

################################################################################
=comment

Perl Weekly Challenge 306
=========================

TASK #2
-------
*Last Element*

Submitted by: Mohammad Sajid Anwar

You are given a array of integers, @ints.

Write a script to play a game where you pick two biggest integers in the given
array, say x and y. Then do the following:

  a) if x == y then remove both from the given array
  b) if x != y then remove x and replace y with (y - x)

At the end of the game, there is at most one element left.

Return the last element if found otherwise return 0.

Example 1

  Input: @ints = (3, 8, 5, 2, 9, 2)
  Output: 1

  Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
  Step 2: pick 3 and 5 => (2, 2, 1, 2)
  Step 3: pick 2 and 1 => (1, 2, 2)
  Step 4: pick 2 and 1 => (1, 2)
  Step 5: pick 1 and 2 => (1)

Example 2

  Input: @ints = (3, 2, 5)
  Output: 0

  Step 1: pick 3 and 5 => (2, 2)
  Step 2: pick 2 and 2 => ()

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The input integers are positive (greater than zero).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more positive integers are entered on the command-line.

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

    [<ints> ...]    A non-empty list of positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 306, Task #2: Last Element (Perl)\n\n";
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
            $_ > 0                 or error( "$_ is not positive");
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $last_element = find_last_element( \@ints );

        print  "Output: $last_element\n";
    }
}

#-------------------------------------------------------------------------------
sub find_last_element
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @n     = sort { $a <=> $b } @$ints;

    while (scalar @n > 1)
    {
        my $y = pop @n;
        my $x = pop @n;

        if ($y > $x)
        {
            push @n, $y - $x;

            @n = sort { $a <=> $b } @n;
        }
    }

    return (scalar @n == 0) ? 0 : $n[ 0 ];
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
        my $last = find_last_element( \@ints );

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
Example 1|3 8 5 2 9 2|1
Example 2|3 2 5      |0
