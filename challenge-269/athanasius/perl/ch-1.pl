#!perl

################################################################################
=comment

Perl Weekly Challenge 269
=========================

TASK #1
-------
*Bitwise OR*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to find out if it is possible to select two or more elements of
the given array such that the bitwise OR of the selected elements has at least
one trailing zero in its binary representation.

Example 1

  Input: @ints = (1, 2, 3, 4, 5)
  Output: true

  Say, we pick 2 and 4, their bitwise OR is 6. The binary representation of 6 is
  110. Return true since we have one trailing zero.

Example 2

  Input: @ints = (2, 3, 8, 16)
  Output: true

  Say, we pick 2 and 8, their bitwise OR is 10. The binary representation of 10
  is 1010. Return true since we have one trailing zero.

Example 3

  Input: @ints = (1, 2, 5, 7, 9)
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The "positive" integers are the unsigned integers (which include zero).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.
3. If VERBOSE is set to a true value, the output gives the result (true or
   false) followed by a brief explanation; otherwise, only the result is given.

Algorithm
---------
For bitwise OR, 0 OR 0 = 0, 0 OR 1 = 1, 1 OR 0 = 1, and 1 OR 1 = 1. Therefore,
the only way two binary operands will produce a zero as the least significant
digit when OR-ed together is if both operands end in a zero.

An unsigned integer's binary representation ends in a zero if and only if the
integer is even (i.e., divisible by 2 without remainder).

So, the algorithm is to search the input for even numbers. If two or more are
found, a solution is possible and the result is true; otherwise, no solution is
possible and the result is false.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
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
    print "\nChallenge 269, Task #1: Bitwise OR (Perl)\n\n";
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

        my $result = test_bitwise_OR( \@ints );

        printf "Output: %s\n", defined $result ? 'true' : 'false';

        explain_result( $result ) if $VERBOSE;
    }
}

#-------------------------------------------------------------------------------
sub test_bitwise_OR
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my ($result, $first);

    for my $n (sort { $a <=> $b } @$ints)
    {
        if ($n % 2 == 0)
        {
            if (defined $first)
            {
                $result = [ $first, $n ];
                last;
            }
            else
            {
                $first = $n;
            }
        }
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub explain_result
#-------------------------------------------------------------------------------
{
    my ($result) = @_;

    if (defined $result)
    {
        my $i     = $result->[ 0 ];
        my $j     = $result->[ 1 ];
        my $width = length sprintf '%b', $j;

        printf "\n(%d, %d) is a solution because (%0*b OR %b) = %b\n",
                $i, $j, $width, $i, $j, $i | $j;
    }
    else
    {
        print  "\nThere are no solutions\n";
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test, $ints_str, $exp_str, $exp1, $exp2) = split / \| /x, $line;

        for ($test, $ints_str, $exp_str, $exp1, $exp2)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints   = split / \s+ /x, $ints_str;
        my $result = test_bitwise_OR( \@ints );
        my $exp    = $exp_str eq 'true';

        is  defined $result,   $exp,  "$test: Bool";

        if (defined $result)
        {
            is $result->[ 0 ], $exp1, "$test: Op 1";
            is $result->[ 1 ], $exp2, "$test: Op 2";
        }
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
Example 1| 1 2 3  4 5|true |2|4
Example 2| 2 3 8 16  |true |2|8
Example 3| 1 2 5  7 9|false| |
Singleton|42         |false| |
