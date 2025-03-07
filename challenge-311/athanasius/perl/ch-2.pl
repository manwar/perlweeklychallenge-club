#!perl

################################################################################
=comment

Perl Weekly Challenge 311
=========================

TASK #2
-------
*Group Digit Sum*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, made up of digits, and an integer, $int, which is
less than the length of the given string.

Write a script to divide the given string into consecutive groups of size $int
(plus one for leftovers if any). Then sum the digits of each group, and con-
catenate all group sums to create a new string. If the length of the new string
is less than or equal to the given integer then return the new string, otherwise
continue the process.

Example 1

  Input: $str = "111122333", $int = 3
  Output: "359"

  Step 1: "111", "122", "333" => "359"

Example 2

  Input: $str = "1222312", $int = 2
  Output: "76"

  Step 1: "12", "22", "31", "2" => "3442"
  Step 2: "34", "42" => "76"

Example 3

  Input: $str = "100012121001", $int = 4
  Output: "162"

  Step 1: "1000", "1212", "1001" => "162"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. If $int = 1, the summing operation leaves the string unchanged and so the
   algorithm never terminates. Therefore, $int > 1.
2. Since $int >= 2 and < (length of $str), $str must contain at least 3 digits.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string $str of 3 or more digits is entered on the command-line, followed by
   an integer $int such that 1 < $int < (length of $str).

=cut
#===============================================================================

use v5.32;          # Enables strictures and warnings
use Const::Fast;
use Regexp::Common  qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str> <int>
  perl $0

    <str>    A string of three or more digits
    <int>    An integer greater than one and less than the length of \$str
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 311, Task #2: Group Digit Sum (Perl)\n\n";
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
    elsif ($argc == 2)
    {
        my ($str, $int) = @ARGV;

        $str =~ / ^ [0-9]{3,} $ /x
            or error( qq["$str" is not a valid value for \$str] );

        $int =~ / ^ $RE{num}{int} $ /x
            or error( qq["$int" is not a valid integer]);

        1 < $int < length $str
            or error( "$int is not a valid size for \$int" );

        print qq[Input:  \$str = "$str", \$int = $int\n];

        my $sum = group_digit_sum( $str, $int );

        print qq[Output: "$sum"\n];
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub group_digit_sum
#-------------------------------------------------------------------------------
{
    my ($str, $int) = @_;
    my  @digits = split '', $str;

    while (scalar @digits > $int)
    {
        my @sum;

        while (@digits)
        {
            my $sum = 0;

            for (1 .. $int)
            {
                $sum += shift @digits if @digits;
            }

            push @sum, split '', $sum;
        }

        @digits = @sum;
    }

    return join '', @digits;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $int, $expected) = split / \| /x, $line;

        for ($test_name, $str, $int, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $sum = group_digit_sum( $str, $int );

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
Example 1|111122333   |3|359
Example 2|1222312     |2|76
Example 3|100012121001|4|162
Max pairs|999999      |2|99
