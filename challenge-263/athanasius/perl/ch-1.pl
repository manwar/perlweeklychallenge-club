#!perl

################################################################################
=comment

Perl Weekly Challenge 263
=========================

TASK #1
-------
*Target Index*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and a target element $k.

Write a script to return the list of indices in the sorted array where the
element is same as the given target element.

Example 1

  Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
  Output: (1, 2)

  Sorted array: (1, 2, 2, 3, 4, 5)
  Target indices: (1, 2) as $ints[1] = 2 and $k[2] = 2

Example 2

  Input: @ints = (1, 2, 4, 3, 5), $k = 6
  Output: ()

  No element in the given array matching the given target.

Example 3

  Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
  Output: (4)

  Sorted array: (1, 2, 2, 3, 4, 5)
  Target index: (4) as $ints[4] = 4

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
2. The divisor $k is given on the command-line as a named argument, followed by
   a (possibly empty) unnamed list of integers.
3. If any integer in the list (i.e., following $k) on the command-line is
   negative, the first such integer must be preceded by "--" to indicate that
   what follows does not contain command-line flags.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-k[=Int]] [<ints> ...]
  perl $0

    -k[=Int]        The target element
    [<ints> ...]    A list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 263, Task #1: Target Index (Perl)\n\n";
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
        my ($ints, $k) = parse_command_line();

        printf "Input:  \@ints = (%s), \$k = %d\n", join( ', ', @$ints ), $k;

        my $indices = find_target_indices( $ints, $k );

        printf "Output: (%s)\n", join ', ', @$indices;
    }
}

#-------------------------------------------------------------------------------
sub find_target_indices
#-------------------------------------------------------------------------------
{
    my ($ints, $k) = @_;
    my  @sorted    = sort { $a <=> $b } @$ints;
    my  @indices;

    for my $i (0 .. $#sorted)
    {
        push @indices, $i if $sorted[ $i ] == $k;
    }

    return \@indices;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $k;

    GetOptions
    (
        'k=i' => \$k,
    )                          or error( 'Invalid command line argument(s)' );

    defined $k                 or error( '$k is missing' );

    for (@ARGV, $k)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
    }

    return (\@ARGV, $k);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $k, $expected_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $k, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $ints_str;
        my @expected = split / \s+ /x, $expected_str;
        my $indices  = find_target_indices( \@ints, $k );

        is_deeply $indices, \@expected, $test_name;
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
Example 1| 1  5  3 2 4  2| 2|1 2
Example 2| 1  2  4 3 5   | 6|
Example 3| 5  3  2 4 2  1| 4|4
Negatives|-1 -2 -3 0 4 -3|-3|0 1
