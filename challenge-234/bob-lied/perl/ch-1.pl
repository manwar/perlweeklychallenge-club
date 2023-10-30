#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 234 Task 1 Common Characters 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of words made up of alphabetic characters only.
# Write a script to return all alphabetic characters that show up in all
# words including duplicates.
# Example 1 Input: @words = ("java", "javascript", "julia")
#           Output: ("j", "a")
# Example 2 Input: @words = ("bella", "label", "roller")
#           Output: ("e", "l", "l")
# Example 3 Input: @words = ("cool", "lock", "cook")
#           Output: ("c", "o")
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

use Hash::Ordered;
use List::Util qw/min/;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Use counts of letters from each word

sub letterFreq($word)
{
    my %freq;
    $freq{$_}++ for split(//, $word);
    return \%freq;
}

sub commonCharacters(@words)
{
    return [] unless @words;

    my $start = shift @words;

    # Find the count of each possible letter from the first word
    my $letters = letterFreq($start);

    # Use each subsequent word as a filter for the possible letters.
    while ( @words and keys %{$letters} )
    {
        my $wfreq = letterFreq(shift @words);

        for my $char ( keys %{$letters} )
        {
            if ( exists $wfreq->{$char} )
            {
                $letters->{$char} = min($letters->{$char}, $wfreq->{$char});
            }
            else
            {
                delete $letters->{$char};
            }
        }
    }

    # Show the remaining letters, in the order of the first word
    return [ grep { defined }
        map { ( exists $letters->{$_} && $letters->{$_} > 0 )
                  ? do { $letters->{$_}--; $_ }
                  : undef  }
            split(//, $start) ]
}

sub runTest
{
    use Test2::V0;

    is( commonCharacters("java", "javascript", "julia"), ["j", "a"],      "Example 1");
    is( commonCharacters("bella", "label", "roller"),    ["e", "l", "l"], "Example 2");
    is( commonCharacters("label", "bella", "roller"),    ["l", "e", "l"], "Example 2a");
    is( commonCharacters("cool", "lock", "cook"),        ["c", "o"],      "Example 3");

    is( commonCharacters("abc", "def", "xyz"),        [],       "No common");
    is( commonCharacters("ghi", "ghi", "ghi"), ["g", "h", "i"], "All common");
    is( commonCharacters("one"), ["o", "n", "e"], "One word");
    is( commonCharacters(), [], "Empty list");

    done_testing;
}
