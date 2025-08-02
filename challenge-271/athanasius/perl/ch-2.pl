#!perl

################################################################################
=comment

Perl Weekly Challenge 271
=========================

TASK #2
-------
*Sort by 1 bits*

Submitted by: Mohammad Sajid Anwar

You are give an array of integers, @ints.

Write a script to sort the integers in ascending order by the number of 1 bits
in their binary representation. In case more than one integers have the same
number of 1 bits then sort them in ascending order.

Example 1

  Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
  Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

  0 = 0 one bits
  1 = 1 one bits
  2 = 1 one bits
  4 = 1 one bits
  8 = 1 one bits
  3 = 2 one bits
  5 = 2 one bits
  6 = 2 one bits
  7 = 3 one bits

Example 2

  Input: @ints = (1024, 512, 256, 128, 64)
  Output: (64, 128, 256, 512, 1024)

  All integers in the given array have one 1-bits, so just sort them in ascend-
  ing order.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The integers in @int are unsigned (i.e., non-negative).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The elements of @ints are entered in sequence on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    Non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 271, Task #2: Sort by 1 bits (Perl)\n\n";
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
            $_ >= 0                or error( qq["$_" is negative] );
        }

        printf "Input: \@ints = (%s)\n", join ', ', @ints;

        my $sorted = sort_by_one_bits( \@ints );

        printf "Output:        (%s)\n",  join ', ', @$sorted;
    }
}

#-------------------------------------------------------------------------------
sub sort_by_one_bits
#-------------------------------------------------------------------------------
{
    my ($ints)  = @_;
    my  @sorted = sort {
                           count_one_bits( $a ) <=> count_one_bits( $b ) ||
                                           $a   <=>   $b
                       } @$ints;

    return \@sorted;
}

#-------------------------------------------------------------------------------
sub count_one_bits
#-------------------------------------------------------------------------------
{
    my ($decimal) = @_;
    my  $binary   = sprintf '%b', $decimal;

    return $binary =~ tr/1/1/;                 # Count the 1's
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $ints_str;
        my $sorted   = sort_by_one_bits( \@ints );
        my @expected = split / \s+ /x, $expected_str;

        is_deeply $sorted, \@expected, $test_name;
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
Example 1|0 1 2 3 4 5 6 7 8  |0 1 2 4 8 3 5 6 7
Example 2|1024 512 256 128 64|64 128 256 512 1024
