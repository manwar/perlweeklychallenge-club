#!perl

################################################################################
=comment

Perl Weekly Challenge 316
=========================

TASK #2
-------
*Subsequence*

Submitted by: Mohammad Sajid Anwar

You are given two string.

Write a script to find out if one string is a subsequence of another.

  A subsequence of a string is a new string that is formed from the original
  string by deleting some (can be none) of the characters without disturbing the
  relative positions of the remaining characters.

Example 1

  Input: $str1 = "uvw", $str2 = "bcudvew"
  Output: true

Example 2

  Input: $str1 = "aec", $str2 = "abcde"
  Output: false

Example 3

  Input: $str1 = "sip", $str2 = "javascript"
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Matching is case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line.

=cut
#===============================================================================

use v5.32;        # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str1> <str2>
  perl $0

    <str1>    First  string
    <str2>    Second string
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 316, Task #2: Subsequence (Perl)\n\n";
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

        my $is_subsequence = subsequence( $str1, $str2 );

        printf "Output: %s\n", $is_subsequence ? 'true' : 'false';
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub subsequence
#-------------------------------------------------------------------------------
{
    my ($str1, $str2) = @_;

    return contains( $str1, $str2 ) ||
           contains( $str2, $str1 );
}

#-------------------------------------------------------------------------------
sub contains
#-------------------------------------------------------------------------------
{
    my ($str1, $str2) = @_;
    my  @whole = split //, $str1;
    my  @part  = split //, $str2;

    while (@whole && @part && @whole >= @part)
    {
        my $target = shift @part;
        my $found  = '';

        while (@whole)
        {
            my $next = shift @whole;

            if ($next eq $target)
            {
                $found = 1;
                last;
            }
        }

        return '' unless $found;
    }

    return scalar @part == 0;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str1, $str2, $expected_str) = split / \| /x, $line;

        for ($test_name, $str1, $str2, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $is_subsequence = subsequence( $str1, $str2 );
        my $expected       = $expected_str eq 'true';

        is $is_subsequence, $expected, $test_name;
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
Example 1 |uvw    |bcudvew   |true
Example 2 |aec    |abcde     |false
Example 3 |sip    |javascript|true
Identical |abcde  |abcde     |true
Example 1a|bcudvew|uvw       |true
Empty 1   |       |uvwxyz    |true
Empty 2   |uvwxyz |          |true
Empty 3   |       |          |true
Doubled   |abbcdef|abccdef   |false
Case      |Abccde |AbccxzDe  |false
