#!perl

################################################################################
=comment

Perl Weekly Challenge 335
=========================

TASK #1
-------
*Common Characters*

Submitted by: Mohammad Sajid Anwar

You are given an array of words.

Write a script to return all characters that is in every word in the given array
including duplicates.

Example 1

  Input: @words = ("bella", "label", "roller")
  Output: ("e", "l", "l")

Example 2

  Input: @words = ("cool", "lock", "cook")
  Output: ("c", "o")

Example 3

  Input: @words = ("hello", "world", "pole")
  Output: ("l", "o")

Example 4

  Input: @words = ("abc", "def", "ghi")
  Output: ()

Example 5

  Input: @words = ("aab", "aac", "aaa")
  Output: ("a", "a")

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
2. A list of words is entered on the command-line.

=cut
#===============================================================================

use v5.32;       # Enables strictures
use warnings;
use Const::Fast;
use Set::Bag;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<words> ...]
  perl $0

    [<words> ...]    A list of words
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 335, Task #1: Common Characters (Perl)\n\n";
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

        my $common = find_common_chars( \@words );

        printf "Output: (%s)\n",           join ', ', map { qq["$_"] } @$common;
    }
}

#-------------------------------------------------------------------------------
sub find_common_chars
#-------------------------------------------------------------------------------
{
    my ($words) = @_;
    my  $shared = Set::Bag->new;

    if (scalar @$words > 0)
    {
        $shared->insert( $_ => 1 ) for split //, $words->[ 0 ];

        for my $i (1 .. $#$words)
        {
            my $chars = Set::Bag->new;
               $chars->insert( $_ => 1 ) for split //, $words->[ $i ];

            $shared = $shared & $chars;             # Keep only the intersection
        }
    }

    my   @common;
    push @common, ($_) x $shared->grab( $_ ) for sort $shared->elements;

    return \@common;
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
        my $common   = find_common_chars( \@words );
        my @expected = split / \s+ /x, $exp_str;

        is_deeply $common, \@expected, $test_name;
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
Example 1|bella label roller|e l l
Example 2|cool  lock  cook  |c o
Example 3|hello world pole  |l o
Example 4|abc   def   ghi   |
Example 5|aab   aac   aaa   |a a
