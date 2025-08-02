#!perl

################################################################################
=comment

Perl Weekly Challenge 258
=========================

TASK #1
-------
*Count Even Digits Number*

Submitted by: Mohammad Sajid Anwar

You are given a array of positive integers, @ints.

Write a script to find out how many integers have even number of digits.

Example 1

  Input: @ints = (10, 1, 111, 24, 1000)
  Output: 3

  There are 3 integers having even digits i.e. 10, 24 and 1000.

Example 2

  Input: @ints = (111, 1, 11111)
  Output: 0

Example 3

  Input: @ints = (2, 8, 1024, 256)
  Output: 1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
"Positive" integers are greater than or equal to zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the required output is followed by a list
   of the even-digit numbers found.

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

    [<ints> ...]    A non-empty list of positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 258, Task #1: Count Even Digits Number (Perl)\n\n";
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

        my $evens = find_even_digit_numbers( \@ints );

        printf "Output: %d\n", scalar @$evens;

        if ($VERBOSE)
        {
            printf "\nEven-digit integers: %s\n",
                    join ', ', sort { $a <=> $b } @$evens;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_even_digit_numbers
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @evens;

    for my $i (@$ints)
    {
        push @evens, $i if length( $i ) % 2 == 0;
    }

    return \@evens;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $expected) = split / \| /x, $line;

        for ($test_name, $int_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints  = split / \s+ /x, $int_str;
        my $evens = find_even_digit_numbers( \@ints );

        is scalar @$evens, $expected, $test_name;
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
Example 1| 10 1   111  24 1000|3
Example 2|111 1 11111         |0
Example 3|  2 8  1024 256     |1
