#!perl

################################################################################
=comment

Perl Weekly Challenge 344
=========================

TASK #1
-------
*Array Form Compute*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer, $x.

Write a script to add $x to the integer in the array-form.

    The array form of an integer is a digit-by-digit representation stored as an
    array, where the most significant digit is at the 0th index.

Example 1

  Input: @ints = (1, 2, 3, 4), $x = 12
  Output: (1, 2, 4, 6)

Example 2

  Input: @ints = (2, 7, 4), $x = 181
  Output: (4, 5, 5)

Example 3

  Input: @ints = (9, 9, 9), $x = 1
  Output: (1, 0, 0, 0)

Example 4

  Input: @ints = (1, 0, 0, 0, 0), $x = 9999
  Output: (1, 9, 9, 9, 9)

Example 5

  Input: @ints = (0), $x = 1000
  Output: (1, 0, 0, 0)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
----------
1. The integers are all unsigned.
2. An array-form representation should contain no leading (redundant) zeros.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 2 or more unsigned integers is entered on the command-line. The
   last of these is $x; the rest are single digits and make up @ints.

=cut
#===============================================================================

use v5.38.2;        # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of digits followed by an unsigned integer (\$x)
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 344, Task #1: Array Form Compute (Perl)\n\n";
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
    elsif ($argc == 1)
    {
        error( 'Expected 0 or 2+ command-line arguments, found 1' );
    }
    else
    {
        my @ints = @ARGV;
        my $x    = pop @ints;

        for (@ints)
        {
              / ^ [0-9]  $ /x or error( "$_ is not a valid digit" );
        }

        $x =~ / ^ [0-9]+ $ /x or error( '$x is not a valid integer' );

        printf "Input:  \@ints = (%s), \$x = %d\n", join( ', ', @ints ), $x;

        my $sum = add_array_form( \@ints, $x );

        printf "Output: (%s)\n", join ', ', @$sum;
    }
}

#-------------------------------------------------------------------------------
sub add_array_form
#-------------------------------------------------------------------------------
{
    my ($ints, $x) = @_;
    my  $dim       = max( scalar @$ints, length $x ) + 1;
    my  @x_ar      = split //, $x;
    my  @sum       = (0) x $dim;
    my  $carry     =  0;

    unshift @x_ar,  0 until scalar @x_ar  == $dim;
    unshift @$ints, 0 until scalar @$ints == $dim;

    for my $i (reverse( 0 .. $#sum ))
    {
        my $sum  = $ints->[$i] + $x_ar[$i] + $carry;
        $sum[$i] = $sum % 10;
        $carry   = $sum / 10;
    }

    shift @sum while $sum[0] == 0 && scalar @sum > 1;

    return \@sum;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $x, $expd_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $x, $expd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $sum  = add_array_form( \@ints, $x );
        my @expd = split / \s+ /x, $expd_str;

        is_deeply $sum, \@expd, $test_name;
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

#-------------------------------------------------------------------------------
sub max
#-------------------------------------------------------------------------------
{
    my ($lhs, $rhs) = @_;

    return $lhs > $rhs ? $lhs : $rhs;
}

################################################################################

__DATA__
Example 1|1 2 3 4  |  12|1 2 4 6
Example 2|2 7 4    | 181|4 5 5
Example 3|9 9 9    |   1|1 0 0 0
Example 4|1 0 0 0 0|9999|1 9 9 9 9
Example 5|0        |1000|1 0 0 0
