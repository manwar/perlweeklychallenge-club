#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 233 Task 1 Similar Words 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of words made up of alphabets only.
# Write a script to find the number of pairs of similar words. Two words are
# similar if they consist of the same characters.
# Example 1 Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
#           Output: 2
#   Pair 1: similar words ("aba", "aabb")
#   Pair 2: similar words ("bac", "aabc")
# Example 2 Input: @words = ("aabb", "ab", "ba")
#           Output: 3
#   Pair 1: similar words ("aabb", "ab")
#   Pair 2: similar words ("aabb", "ba")
#   Pair 3: similar words ("ab", "ba")
# Example 3 Input: @words = ("nba", "cba", "dba")
#           Output: 0
#=============================================================================

use v5.36;

use List::Util qw/uniq/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say similarWords(@ARGV);

sub wordHash($word)
{
    join "", uniq sort { $a cmp $b } split(//, $word)
}

sub similarWords(@wordList)
{
    my %similar;
    for my $word ( @wordList )
    {
        # Could just increment a count, but saving the word makes it
        # possible to see the list of similar words
        push @{$similar{wordHash($word)}}, $word;
    }

    if ( $Verbose )
    {
        my $group = 1;
        for my $h (keys %similar)
        {
            my $n = scalar $similar{$h}->@*;
            next unless $n > 1;
            say "Group $group ($n -> ", $n*($n-1)/2," pairs): ", join(" ", $similar{$h}->@*);
        }
    }

    # The number of pairs from a list is the combination of N things taken
    # 2 at a time, or N(N-1)/2 = (N^2 -N)/2
    my $pairCount = 0;
    for my $h ( keys %similar)
    {
        my $n = scalar $similar{$h}->@*;
        next unless $n > 1;
        $pairCount += $n*($n-1) / 2;
    }
    return $pairCount;
}

sub runTest
{
    use Test2::V0;

    is(similarWords( qw(aba aabb abcvd bac aabc) ), 2, "Example 1");
    is(similarWords( qw(aabb ab ba             ) ), 3, "Example 2");
    is(similarWords( qw(nba cba dba            ) ), 0, "Example 3");


    is(similarWords( "", qw(nba cba dba            ) ), 0, "Zero length word");
    is(similarWords( "", qw(bba aba dba            ) ), 1, "Zero length word with a pair`");

    is(similarWords( qw(abc abc abc abc        ) ), 6, "Duplicates");

    done_testing;
}
