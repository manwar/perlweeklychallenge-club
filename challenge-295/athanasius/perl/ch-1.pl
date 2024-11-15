#!perl

################################################################################
=comment

Perl Weekly Challenge 295
=========================

TASK #1
-------
*Word Break*

Submitted by: Mohammad Sajid Anwar

You are given a string, $str, and list of words, @words.

Write a script to return true or false whether the given string can be segmented
into a space separated sequence of one or more words from the given list.

Example 1

  Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
  Output: true

Example 2

  Input: $str = "perlrakuperl", @words = ("raku", "perl")
  Output: true

Example 3

  Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Neither $str nor the elements of @words contain whitespace characters.
2. There must be at least one element in @words.
3. Every element of @words must contain at least one character.
4. String comparisons are case-sensitive.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A string, and a non-empty list of words, are entered on the command-line.

Algorithm
---------
Recursive search: For each entry in the @words list, check whether it matches at
the very beginning of the string. If it does, remove it and continue the search
recursively on the string that remains. If at any point the string reduces to
the empty string, the search is successful. Otherwise, the search fails.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <str> [<words> ...]
  perl $0

    <str>            A string to be segmented (no whitespace)
    [<words> ...]    A non-empty list of strings (each not empty, no whitespace)
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 295, Task #1: Word Break (Perl)\n\n";
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
        error( 'Expected 0 or 2+ command-line arguments, found 1' );
    }
    else
    {
        my $str   = shift @ARGV;
        my @words = @ARGV;

        $str =~ / \s /x and error( 'The input string contains whitespace' );

        for (@words)
        {
            length > 0  or  error( 'Empty word' );
            / \s /x     and error( qq[The word "$_" contains whitespace] );
        }

        printf "Input:  \$str = '%s', \@words = (%s)\n",
                $str, join ', ', map { qq["$_"] } @words;

        my $can_segment = can_segment_str( $str, \@words );

        printf "Output: %s\n", $can_segment ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub can_segment_str
#-------------------------------------------------------------------------------
{
    my ($str, $words) = @_;

    return 1 if $str eq '';                                     # Base case 1

    for my $word (@$words)
    {
        if ($str =~ / ^ $word /x)
        {
            my $str1 = $str =~ s/ ^ $word //rx;                 # Reductive step

            return 1 if can_segment_str( $str1, $words );       # Recursive call
        }
    }

    return 0;                                                   # Base case 2
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $str, $words_str, $expected) = split / \| /x, $line;

        for ($test_name, $str, $words_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @words       = split / \s+ /x, $words_str;
        my $can_segment = can_segment_str( $str, \@words ) ? 'true' : 'false';

        is $can_segment, $expected, $test_name;
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
Example 1|weeklychallenge |challenge weekly         |true
Example 2|perlrakuperl    |raku perl                |true
Example 3|sonsanddaughters|sons sand daughters      |false
Overlap  |fishnetworkplace|network fishnet workplace|true
