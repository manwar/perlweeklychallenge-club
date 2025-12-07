#!perl

################################################################################
=comment

Perl Weekly Challenge 350
=========================

TASK #1
-------
*Good Substrings*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to return the number of good substrings of length three in the
given string.

    A string is good if there are no repeated characters.

Example 1

  Input: $str = "abcaefg"
  Output: 5

  Good substrings of length 3: abc, bca, cae, aef and efg

Example 2

  Input: $str = "xyzzabc"
  Output: 3

  Good substrings of length 3: "xyz", "zab" and "abc"

Example 3

  Input: $str = "aababc"
  Output: 1

  Good substrings of length 3: "abc"

Example 4

  Input: $str = "qwerty"
  Output: 4

  Good substrings of length 3: "qwe", "wer", "ert" and "rty"

Example 5

  Input: $str = "zzzaaa"
  Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;    # Enables strictures
use warnings;
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
    print "\nChallenge 350, Task #1: Good Substrings (Perl)\n\n";
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
        my $str = $ARGV[0];

        print qq[Input:  \$str = "$str"\n];

        my $count = count_good_substrings( $str );

        print "Output: $count\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_good_substrings
#-------------------------------------------------------------------------------
{
    my ($str)  = @_;
    my  $count = 0;

    while ($str =~ / (.) (?=(..)) /gx)
    {
        my $x = $1;
        my $y = substr $2, 0, 1;
        my $z = substr $2, 1, 1;

        ++$count if $x ne $y && $x ne $z && $y ne $z;
    }

    return $count;
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

        my $count = count_good_substrings( $str );

        is $count, $expected, $test_name;
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
Example 1|abcaefg|5
Example 2|xyzzabc|3
Example 3|aababc |1
Example 4|qwerty |4
Example 5|zzzaaa |0
