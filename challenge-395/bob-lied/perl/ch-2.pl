#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 395 Task 2  Word Squares
#=============================================================================
# You are given a list of equal lengths words.  Write a script to arrange a
# set of words into a grid that reading across any row gives the exact same
# word as reading down its corresponding column.
# Example 1 Input: @words = ("MA", "AM", "MY", "ME")
#           Output: ("MA", "AM")
#           M A
#           A M
# Example 2 Input: @words = ("SUN", "USE", "NET", "SEE", "TEN")
#           Output: ("SUN", "USE", "NET")
#           S U N
#           U S E
#           N E T
# Example 3 Input: @words = ("BOAT", "TEAL", "AREA", "TSAR", "OGRE")
#           Output: ("BOAT", "OGRE", "AREA", "TEAL")
#           B O A T
#           O G R E
#           A R E A
#           T E A L
# Example 4 Input: @words = ("CARD", "AREA", "REAR", "DART")
#           Output: ("CARD", "AREA", "REAR", "DART")
#           C A R D
#           A R E A
#           R E A R
#           D A R T
# Example 5 Input: @words = ("HEART", "TREND", "EMBER", "RESIN", "ABUSE")
#           Output: ("HEART", "EMBER", "ABUSE", "RESIN", "TREND")
#           H E A R T
#           E M B E R
#           A B U S E
#           R E S I N
#           T R E N D
#=============================================================================

use v5.44;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say '(', join(", ", task(@ARGV)->@*), ')';

#=============================================================================

# Form a word by taking the nth column out of each word in the list
sub colWord($n, $wordList)
{
    return join "", map { substr($_, $n, 1) } $wordList->@*;
}

sub task(@words)
{
    use Algorithm::Combinatorics qw/combinations permutations/;
    use List::Util qw/any all/;

    my $dimension = length($words[0]);
    if ( any { length($_) != $dimension } @words )
    {
        $logger->error("All words must be same length");
        return [];
    }
    if ( $dimension > @words )
    {
        $logger->error("Not enough words");
        return [];
    }

    # Check all groups of N words
    my $groupIter = combinations(\@words, $dimension);
    while ( my $group = $groupIter->next() )
    {
        # Check all permutations of a group
        my $listIter = permutations($group);
        while ( my $list = $listIter->next() )
        {
            # Does this set of words form a square? 
            if ( all { colWord($_, $list) eq $list->[$_] } ( 0 .. ($dimension-1) ) )
            {
                return $list;
            }
        }
    }
    return [];
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("MA", "AM", "MY", "ME"), ["MA", "AM"], "Example 1");
    is( task("SUN", "USE", "NET", "SEE", "TEN"), ["SUN", "USE", "NET"], "Example 2");
    is( task("BOAT", "TEAL", "AREA", "TSAR", "OGRE"), ["BOAT", "OGRE", "AREA", "TEAL"], "Example 3");
    is( task("CARD", "AREA", "REAR", "DART"), ["CARD", "AREA", "REAR", "DART"], "Example 4");
    is( task("HEART", "TREND", "EMBER", "RESIN", "ABUSE"), ["HEART", "EMBER", "ABUSE", "RESIN", "TREND"], "Example 5");

    is( task("THIS", "CANT", "WORK", "EVER"), [], "No combo works");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

