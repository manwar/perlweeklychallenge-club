#!perl

################################################################################
=comment

Perl Weekly Challenge 251
=========================

TASK #1
-------
*Concatenation Value*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

Write a script to find the concatenation value of the given array.

The concatenation of two numbers is the number formed by concatenating their
numerals.

  For example, the concatenation of 10, 21 is 1021.
  The concatenation value of @ints is initially equal to 0.
  Perform this operation until @ints becomes empty:

  If there exists more than one number in @ints, pick the first element
  and last element in @ints respectively and add the value of their
  concatenation to the concatenation value of @ints, then delete the
  first and last element from @ints.

  If one element exists, add its value to the concatenation value of
  @ints, then delete it.

Example 1

  Input: @ints = (6, 12, 25, 1)
  Output: 1286

  1st operation: concatenation of 6 and 1 is 61
  2nd operation: concaternation of 12 and 25 is 1225

  Concatenation Value => 61 + 1225 => 1286

Example 2

  Input: @ints = (10, 7, 31, 5, 2, 2)
  Output: 489

  1st operation: concatenation of 10 and 2 is 102
  2nd operation: concatenation of 7 and 2 is 72
  3rd operation: concatenation of 31 and 5 is 315

  Concatenation Value => 102 + 72 + 315 => 489

Example 3

  Input: @ints = (1, 2, 10)
  Output: 112

  1st operation: concatenation of 1 and 10 is 110
  2nd operation: only element left is 2

  Concatenation Value => 110 + 2 => 112

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The input integers are unsigned (i.e., non-negative).

Rationale: If the right hand side of a concatenation is a negative integer, then
the result of the concatenation will not be an integer. (For example, "3" con-
catenated with "-45" gives "3-45", which is not an integer.) The simplest way to
avoid this possibility is to disallow negative numbers in the input.

Interface
---------
If no command-line arguments are given, the test suite is run.

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

    [<ints> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 251, Task #1: Concatenation Value (Perl)\n\n";
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
        my   @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );

            $_ >= 0                or error( "$_ is negative" );
        }

        printf "Input:  \@ints = (%s)\n",  join ', ', @ints;

        my $concat_value = find_concatenation_value( \@ints );

        print  "Output: $concat_value\n";
    }
}

#-------------------------------------------------------------------------------
sub find_concatenation_value
#-------------------------------------------------------------------------------
{
    my ($ints)        = @_;
    my  $concat_value = 0;

    while (@$ints)
    {
        # Addition of 0 normalizes an integer; for example, "+234" becomes "234"

        if (scalar @$ints == 1)
        {
            $concat_value +=  0 + shift @$ints;
        }
        else
        {
            $concat_value += (0 + shift @$ints) . (0 + pop @$ints);
        }
    }

    return $concat_value;
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

        my @ints         = split / \s+ /x, $ints_str;
        my $concat_value = find_concatenation_value( \@ints );

        is $concat_value, $expected, $test_name;
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
Example 1| 6 12 25 1    |1286
Example 2|10  7 31 5 2 2| 489
Example 3| 1  2 10      | 112
