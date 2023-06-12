#!perl

################################################################################
=comment

Perl Weekly Challenge 220
=========================

TASK #1
-------
*Common Characters*

Submitted by: Mohammad S Anwar

You are given a list of words.

Write a script to return the list of common characters (sorted alphabetically)
found in every word of the given list.

Example 1

  Input: @words = ("Perl", "Rust", "Raku")
  Output: ("r")

Example 2

  Input: @words = ("love", "live", "leave")
  Output: ("e", "l", "v")

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Non-alphabetic characters (e.g., the hyphen in "by-laws") should be ignored.

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Set::Tiny;
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<words> ...]
  perl $0

    [<words> ...]    A list of words\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 220, Task #1: Common Characters (Perl)\n\n";
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
        printf "Input:  \@words = (%s)\n", join ', ', map { qq["$_"] } @ARGV;

        my $common = find_common_characters( \@ARGV );

        printf "Output: (%s)\n",           join ', ', map { qq["$_"] } @$common;
    }
}

#-------------------------------------------------------------------------------
sub find_common_characters
#-------------------------------------------------------------------------------
{
    my ($words) = @_;
    my  $common = make_set( $words->[ 0 ] );

    for my $word ((@$words)[ 1 .. $#$words ])
    {
        $common = $common->intersection( make_set( $word ) );
    }

    return [ sort $common->elements ];
}

#-------------------------------------------------------------------------------
sub make_set
#-------------------------------------------------------------------------------
{
    my ($word) = @_;
    my  @chars = map { lc $_ } grep { / ^ [A-Za-z] $ /x } split //, $word;

    return Set::Tiny->new( @chars );
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $words_str, $exptd_str) = split / \| /x, $line;

        for ($test_name, $words_str, $exptd_str)               # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @expected = split / \s+ /x,  $exptd_str;
        my @words    = split / \s+ /x,  $words_str;
        my $solution = find_common_characters( \@words );

        is_deeply $solution, \@expected, $test_name;
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
Example 1 |Perl    Rust          Raku      |r
Example 2 |love    live          leave     |e l v
Hyphenated|by-laws whale-blubber water-baby|a b w
