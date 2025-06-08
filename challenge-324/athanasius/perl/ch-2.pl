#!perl

################################################################################
=comment

Perl Weekly Challenge 324
=========================

TASK #2
-------
*Total XOR*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to return the sum of total XOR for every subset of given array.

Example 1

  Input: @ints = (1, 3)
  Output: 6

  Subset [1],    total XOR = 1
  Subset [3],    total XOR = 3
  Subset [1, 3], total XOR => 1 XOR 3 => 2

  Sum of total XOR => 1 + 3 + 2 => 6

Example 2

  Input: @ints = (5, 1, 6)
  Output: 28

  Subset [5],       total XOR = 5
  Subset [1],       total XOR = 1
  Subset [6],       total XOR = 6
  Subset [5, 1],    total XOR => 5 XOR 1 => 4
  Subset [5, 6],    total XOR => 5 XOR 6 => 3
  Subset [1, 6],    total XOR => 1 XOR 6 => 7
  Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2

  Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28

Example 3

  Input: @ints = (3, 4, 5, 6, 7, 8)
  Output: 480

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The input integers are unsigned.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;            # Enables strictures
use warnings;
use Const::Fast;
use List::Util        qw( reduce  );
use Math::Prime::Util qw( forcomb );
use Regexp::Common    qw( number  );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 324, Task #2: Total XOR (Perl)\n\n";
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
            $_ >= 0                or error( "$_ is negative" );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $sum = find_total_xor( \@ints );

        print  "Output: $sum\n";
    }
}

#-------------------------------------------------------------------------------
sub find_total_xor
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $sum   = 0;

    forcomb
    {
        $sum  += reduce { $a ^ $b } 0, (@$ints)[ @_ ];

    } @$ints;

    return $sum;
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
        my $sum  = find_total_xor( \@ints );

        is $sum, $expected, $test_name;
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
Example 1|1 3        |  6
Example 2|5 1 6      | 28
Example 3|3 4 5 6 7 8|480
