#!perl

################################################################################
=comment

Perl Weekly Challenge 377
=========================

TASK #1
-------
*Reverse Existence*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find whether any substring of length 2 is also present in the
reverse of the given string.

Example 1

  Input: $str = "abcba"
  Output: true

  Reverse of given string is "abcba".
  The substring "ab" in original string is also present in the reverse string
  too.

Example 2

  Input: $str = "racecar"
  Output: true

  The substring "ce" is present in both.

Example 3

  Input: $str = "abcd"
  Output: false

Example 4

  Input: $str = "banana"
  Output: true

  The substring "an" is present in both.

Example 5

  Input: $str = "hello"
  Output: true

  The substring "ll" is present in both.

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
2. A single string is entered on the command-line.

Assumption
----------
Comparisons are case-sensitive.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use boolean;
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
    print "\nChallenge 377, Task #1: Reverse Existence (Perl)\n\n";
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

        my $reverse_exists = reverse_exists( $str );

        printf "Output: %s\n", $reverse_exists ? 'true' : 'false';
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub reverse_exists
#-------------------------------------------------------------------------------
{
    my ($str) = @_;
    my  %dict;

    while ($str =~ /(?=(.)(.))/g)
    {
        return true if $1 eq $2;

        ++$dict{ $1 . $2 };
    }

    for my $key (keys %dict)
    {
        return true if exists $dict{ reverse $key };
    }

    return false;
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

        my $reverse_exists = reverse_exists( $str ) ? 'true' : 'false';

        is $reverse_exists, $expected, $test_name;
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
Example 1|abcba  |true
Example 2|racecar|true
Example 3|abcd   |false
Example 4|banana |true
Example 5|hello  |true
