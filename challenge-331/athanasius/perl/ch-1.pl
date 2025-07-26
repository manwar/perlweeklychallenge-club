#!perl

################################################################################
=comment

Perl Weekly Challenge 331
=========================

TASK #1
-------
*Last Word*

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to find the length of last word in the given string.

Example 1

  Input: $str = "The Weekly Challenge"
  Output: 9

Example 2

  Input: $str = "   Hello   World    "
  Output: 5

Example 3

  Input: $str = "Let's begin the fun"
  Output: 3

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
2. A string is entered on the command-line.

Assumption
----------
All non-word characters, including punctuation, are to be handled like the
whitespace in the Examples.

=cut
#===============================================================================

use v5.32;         # Enables strictures
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
    print "\nChallenge 331, Task #1: Last Word (Perl)\n\n";
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

        my $length = find_last_word_len( $str );

        print "Output: $length\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_last_word_len
#-------------------------------------------------------------------------------
{
    my ($str) = @_;

    $str =~ / (\w+) \W* $ /x;

    return length( $1 // '' );
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, undef, $expected) = split / \| /x, $line;

        for ($test_name, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $length = find_last_word_len( $str );

        is $length, $expected, $test_name;
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
Example 1|The Weekly Challenge|               | 9
Example 2|   Hello   World    |               | 5
Example 3|Let's begin the fun|                | 3
Question |Is this a good question?|           | 8
Empty    ||                                   | 0
No words |. ### //??? * &&& ! #/?*|           | 0
Long word|Supercalifragilisticexpialidocious!||34
