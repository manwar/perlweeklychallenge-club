#!perl

################################################################################
=comment

Perl Weekly Challenge 381
=========================

TASK #2
-------
*Smaller Greater Element*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to find the number of elements that have both a strictly smaller
and greater element in the given array.

Example 1

  Input: @int = (2,4)
  Output: 0

  Not enough elements in the array.

Example 2

  Input: @int = (1, 1, 1, 1)
  Output: 0

Example 3

  Input: @int = (1, 1, 4, 8, 12, 12)
  Output: 2

  The elements are 4 and 8.

Example 4

  Input: @int = (3, 6, 6, 9)
  Output: 2

  Both instances of 6.

Example 5

  Input: @int = (0, -5, 10, -2, 4)
  Output: 3

  The elements are 0, -2, and 4.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( uniqint );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<int> ...]
  perl $0

    [<int> ...]    A non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 381, Task #2: Smaller Greater Element (Perl)\n\n";
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
        my @int = @ARGV;

        for (@int)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        printf "Input:  \@int = (%s)\n", join ', ', @int;

        my $count = count_elements( \@int );

        print  "Output: $count\n";
    }
}

#-------------------------------------------------------------------------------
sub count_elements
#-------------------------------------------------------------------------------
{
    my ($int)   = @_;
    my  $count  = 0;
    my  @sorted = sort { $a <=> $b } @$int;
    my  @unique = uniqint @sorted;

    if (scalar @unique > 2)
    {
        my $min = $unique[ 0];
        my $max = $unique[-1];

        shift @sorted while $sorted[ 0] == $min;
        pop   @sorted while $sorted[-1] == $max;

        $count = scalar @sorted;
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $expected) = split / \| /x, $line;

        for ($test_name, $int_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @int   = split / \s+ /x, $int_str;
        my $count = count_elements( \@int );

        is $count, $expected, $test_name;
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
Example 1|2  4            |0
Example 2|1  1  1  1      |0
Example 3|1  1  4  8 12 12|2
Example 4|3  6  6  9      |2
Example 5|0 -5 10 -2  4   |3
