#!perl

################################################################################
=comment

Perl Weekly Challenge 234
=========================

TASK #1
-------
*Common Characters*

Submitted by: Mohammad S Anwar

You are given an array of words made up of alphabetic characters only.

Write a script to return all alphabetic characters that show up in all words
including duplicates.

Example 1

  Input: @words = ("java", "javascript", "julia")
  Output: ("j", "a")

Example 2

  Input: @words = ("bella", "label", "roller")
  Output: ("e", "l", "l")

Example 3

  Input: @words = ("cool", "lock", "cook")
  Output: ("c", "o")

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Matching is NOT case-sensitive.
2. Characters in the output are listed in the order (and case) they have within
   the first word.

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<words> ...]
  perl $0

    [<words> ...]    A non-empty list of alphabetic words\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 234, Task #1: Common Characters (Perl)\n\n";
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

        / ^ [a-z]+ $ /ix or error( qq["$_" is not a valid word] )  for @words;

        printf "Input:  \@words = (%s)\n", join ', ', map { qq["$_"] } @words;

        my $common = find_common_characters( \@words );

        printf "Output: (%s)\n",           join ', ', map { qq["$_"] } @$common;
    }
}

#-------------------------------------------------------------------------------
sub find_common_characters
#-------------------------------------------------------------------------------
{
    my ($words) = @_;
    my  %common;
      ++$common{ $_ } for split //, lc $words->[ 0 ];

    for my $word (@$words[ 1 .. $#$words ])
    {
        my %next;
         ++$next{ $_ } for split //, lc $word;

        # Find the intersection

        exists $next{ $_ } || delete $common{ $_ } for keys %common;

        for my $chr (keys %next)
        {
            $common{ $chr } = $next{ $chr }
                if exists $common{ $chr } && $next{ $chr } < $common{ $chr };
        }
    }

    my @common;

    for my $chr (split //, $words->[ 0 ])
    {
        my $key = lc $chr;

        if (exists $common{ $key } && $common{ $key } > 0)
        {
            push @common, $chr;
            --$common{ $key };
        }
    }

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

        my @words  = split / \s+ /x, $words_str;
        my @exp    = split / \s+ /x, $exp_str;
        my $common = find_common_characters( \@words );

        is_deeply $common, \@exp, $test_name;
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
Example 1 |java  javascript julia |j a
Example 2 |bella label      roller|e l l
Example 3 |cool  lock       cook  |c o
Mixed case|JavA  javascript julia |J a
