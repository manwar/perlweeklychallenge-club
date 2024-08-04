#!perl

################################################################################
=comment

Perl Weekly Challenge 280
=========================

TASK #2
-------
*Count Asterisks*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, where every two consecutive vertical bars are
grouped into a pair.

Write a script to return the number of asterisks, *, excluding any between each
pair of vertical bars.

Example 1

  Input: $str = "p|*e*rl|w**e|*ekly|"
  Output: 2

  The characters we are looking here are "p" and "w**e".

Example 2

  Input: $str = "perl"
  Output: 0

Example 3

  Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
  Output: 5

  The characters we are looking here are "th", "e**", "l***ych" and "e".

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
Otherwise:
2. A single string is entered on the command-line.

=cut
#===============================================================================

use v5.32;          # Enables strictures and warnings
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str>
  perl $0

    <str>    A string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 280, Task #2: Count Asterisks (Perl)\n\n";
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
        my $str = $ARGV[ 0 ];

        print qq[Input:  \$str = "$str"\n];

        my $asterisks = count_asterisks( $str );

        print "Output: $asterisks\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_asterisks
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    # 1. Remove all bar-pairs (including any asterisks they contain)

    $str =~ s/ \| [^|]* \| //gx;

    # 2. Return the number of asterisks remaining

    return $str =~ tr/*//;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $expected) = split / \! /x, $line;

        for ($test_name, $str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $asterisks = count_asterisks( $str );

        is $asterisks, $expected, $test_name;
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
Example 1     ! p|*e*rl|w**e|*ekly|           ! 2
Example 2     ! perl                          ! 0
Example 3     ! th|ewe|e**|k|l***ych|alleng|e ! 5
Unmatched bar ! a*a|b**b|c***|d****d          ! 8
