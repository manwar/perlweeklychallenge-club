#!perl

################################################################################
=comment

Perl Weekly Challenge 297
=========================

TASK #1
-------
*Contiguous Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of binary numbers, @binary.

Write a script to return the maximum length of a contiguous subarray with an
equal number of 0 and 1.

Example 1

  Input: @binary = (1, 0)
  Output: 2

  (1, 0) is the longest contiguous subarray with an equal number of 0 and 1.

Example 2

  Input: @binary = (0, 1, 0)
  Output: 2

  (1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0
  and 1.

Example 3

  Input: @binary = (0, 0, 0, 0, 0)
  Output: 0

Example 4

  Input: @binary = (0, 1, 0, 0, 1, 0)
  Output: 4

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
2. A non-empty list of binary digits is entered on the command-line; OR
3. A single string of two or more binary digits is entered on the command-line.

Algorithm
---------
Since the longest subarray contains an equal number of ones and zeros:
(a) it cannot be longer than 2n, where n is the smaller of the total numbers of
    ones and zeros in @binary; and
(b) it must be even in length.

Therefore, the search begins with t (the target subarray length) equal to 2n,
and proceeds with t = 2(n - 1), t = 2(n - 2), etc., down to t = 2.

For each value of t, subarrays of length t are searched in @binary from left
(index 0) to right. For example, if @binary is of length 11 and t = 5, the
search begins with @binary[ 0 .. 4 ] and continues with @binary[ 1 .. 5 ],
@binary[ 2 .. 6 ], etc, up to @binary[ 7 .. 11 ].

=cut
#===============================================================================

use v5.32;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util   qw( min );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<binary> ...]
  perl $0

    [<binary> ...]    A non-empty list of binary digits (0, 1)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 297, Task #1: Contiguous Array (Perl)\n\n";
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
        my @binary = length $ARGV[ 0 ] > 1 ? split //, $ARGV[ 0 ] : @ARGV;

        $_ eq '0' || $_ eq '1' or error( qq[Input "$_" is not a binary digit] )
            for @binary;

        printf "Input:  \@binary = (%s)\n", join ', ', @binary;

        my $max_len = solve( \@binary );

        print  "Output: $max_len\n";
    }
}

#-------------------------------------------------------------------------------
sub solve
#-------------------------------------------------------------------------------
{
    my ($binary) = @_;
    my  $size    = scalar @$binary;
    my  $ones    = scalar grep { $_ } @$binary;
    my  $zeros   = $size - $ones;
    my  $target  = 2 * min( $ones, $zeros );

    for (my $t = $target; $t >= 2; $t -= 2)
    {
        for my $i (0 .. $size - $t)
        {
            $ones = scalar grep { $_ } @$binary[ $i .. $i + $t - 1 ];

            return $t if $ones * 2 == $t;
        }
    }

    return 0;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $bin_str, $expected) = split / \| /x, $line;

        for ($test_name, $bin_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @binary  = split //, $bin_str;
        my $max_len = solve( \@binary );

        is $max_len, $expected, $test_name;
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
Example 1|10    |2
Example 2|010   |2
Example 3|00000 |0
Example 4|010010|4
