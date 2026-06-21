#!perl

################################################################################
=comment

Perl Weekly Challenge 378
=========================

TASK #1
-------
*Second Largest Digit*

Submitted by: Mohammad Sajid Anwar

You are given an alphanumeric string.

Write a script to find the second largest distinct digit in the given string.
Return -1 if none found.

Example 1

  Input: $str = "aaaaa77777"
  Output: -1

  The only digit in the given string is 7 and there is no second digit.

Example 2

  Input: $str = "abcde"
  Output: -1

  No numerical digits in the given string.

Example 3

  Input: $str = "9zero8eight7seven9"
  Output: 8

Example 4

  Input: $str = "xyz9876543210"
  Output: 8

Example 5

  Input: $str = "4abc4def2ghi8jkl2"
  Output: 4

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
2. An alphanumeric string is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    An alphanumeric string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 378, Task #1: Second Largest Digit (Perl)\n\n";
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
        my ($str) = @ARGV;

        print qq[Input:  \$str = "$str"\n];

        my $digit = find_digit( $str );

        print "Output: $digit\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_digit
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  %dict;

    for my $char (split //, $str)
    {
        ++$dict{ $char } if $char =~ / ^ [0-9] $ /x;
    }

    my @digits = sort { $b <=> $a } keys %dict;

    return (scalar @digits >= 2) ? $digits[1] : -1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $digit = find_digit( $str );

        is $digit, $expected, $test_name;
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
Example 1|aaaaa77777        |-1
Example 2|abcde             |-1
Example 3|9zero8eight7seven9| 8
Example 4|xyz9876543210     | 8
Example 5|4abc4def2ghi8jkl2 | 4
