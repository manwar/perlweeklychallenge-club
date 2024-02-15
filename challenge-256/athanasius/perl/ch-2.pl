#!perl

################################################################################
=comment

Perl Weekly Challenge 256
=========================

TASK #2
-------
*Merge Strings*

Submitted by: Mohammad Sajid Anwar

You are given two strings, $str1 and $str2.

Write a script to merge the given strings by adding in alternative order start-
ing with the first string. If a string is longer than the other then append the
remaining at the end.

Example 1

  Input: $str1 = "abcd", $str2 = "1234"
  Output: "a1b2c3d4"

Example 2

  Input: $str1 = "abc", $str2 = "12345"
  Output: "a1b2c345"

Example 3

  Input: $str1 = "abcde", $str2 = "123"
  Output: "a1b2c3de"

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use v5.32.1;        # Enables strictures
use warnings;
use Const::Fast;
use List::MoreUtils qw( mesh );
use Test::More;

const my $USAGE => <<END;
Usage:
Usage:
  perl $0 <str1> <str2>
  perl $0

    <str1>    A string
    <str2>    Another string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 256, Task #2: Merge Strings (Perl)\n\n";
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
        my ($str1, $str2) = @ARGV;

        print qq[Input:  \$str1 = "$str1", \$str2 = "$str2"\n];

        my $merged = merge_strings( $str1, $str2 );

        print qq[Output: "$merged"\n];
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub merge_strings
#-------------------------------------------------------------------------------
{
    my ($str1, $str2) = @_;

    my @chars1 = split //, $str1;
    my @chars2 = split //, $str2;
    my @merged = grep { defined } mesh @chars1, @chars2;

    return join '', @merged;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str1, $str2, $expected) = split / \| /x, $line;

        for ($test_name, $str1, $str2, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $merged = merge_strings( $str1, $str2 );

        is $merged, $expected, $test_name;
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
Example 1|abcd |1234 |a1b2c3d4
Example 2|abc  |12345|a1b2c345
Example 3|abcde|123  |a1b2c3de
