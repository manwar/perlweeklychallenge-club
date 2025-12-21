#!perl

################################################################################
=comment

Perl Weekly Challenge 352
=========================

TASK #1
-------
*Match String*

Submitted by: Mohammad Sajid Anwar

You are given an array of strings.

Write a script to return all strings that are a substring of another word in the
given array in the order they occur.

Example 1

  Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat",
                   "ratcatdogcat")
  Output: ("cat", "dog", "dogcat", "rat")

Example 2

  Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
  Output: ("hell", "world", "wor", "ellow")

Example 3

  Input: @words = ("a", "aa", "aaa", "aaaa")
  Output: ("a", "aa", "aaa")

Example 4

  Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
  Output: ("flow", "fl", "fli", "ig", "ght")

Example 5

  Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
  Output: ("car", "pet", "enter", "pen", "pent")

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. "Substring" means "proper substring".
2. The output does not contain duplicates.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of strings is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;     # Enables strictures
use warnings;
use Const::Fast;
use List::Util   qw( none );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<words> ...]
  perl $0

    [<words> ...]    A list of strings
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 352, Task #1: Match String (Perl)\n\n";
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
        my @words = @ARGV;

        printf "Input:  \@words = (%s)\n", join ', ', map { qq["$_"] } @words;
        
        my $matches = find_matches( \@words );

        printf "Output: (%s)\n", join ', ', map { qq["$_"] } @$matches;
    }
}

#-------------------------------------------------------------------------------
sub find_matches
#-------------------------------------------------------------------------------
{
    my ($words) = @_;
    my  @matches;

    for my $i (0 .. $#$words)
    {
        my $word1 = $words->[$i];

        if (none { $_ eq $word1 } @matches)
        {
            for my $j (0 .. $#$words)
            {
                next if $i == $j;

                my $word2 = $words->[$j];

                if ($word1 ne $word2 && $word2 =~ / $word1 /x)
                {
                    push @matches, $word1;
                    last;
                }
            }
        }
    }

    return \@matches;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $words_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @words    = split / \s+ /x, $words_str;
        my $matches  = find_matches( \@words );
        my @expected = split / \s+ /x, $exp_str;

        is_deeply $matches, \@expected, $test_name;
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
Example 1|cat cats dog dogcat dogcat rat ratcatdogcat|cat dog dogcat rat
Example 2|hello hell world wor ellow elloworld       |hell world wor ellow
Example 3|a aa aaa aaaa                              |a aa aaa
Example 4|flower flow flight fl fli ig ght           |flow fl fli ig ght
Example 5|car carpet carpenter pet enter pen pent    |car pet enter pen pent
