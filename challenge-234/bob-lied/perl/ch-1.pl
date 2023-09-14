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

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub commonCharacters(@words)
{
    use List::Util qw/all/;

    return [] unless @words;
    my $start = shift @words;
    my @result;
  LETTER:
    for my $letter ( split(//, $start) )
    {
        if ( all { index($_, $letter) >= 0 } @words )
        {
            # This letter occurs in all words.
            push @result, $letter;

            # Remove the letter from each word
            for my $w ( 0 .. $#words)
            {
                my $pos = index($words[$w], $letter);
                substr($words[$w], $pos, 1, ""); # Remove the letter
                last LETTER if $words[$w] eq "";
            }
        }
    }
    return \@result;
}

# Use counts of letters from each word

sub letterFreq($word)
{
    my %freq;
    $freq{$_}++ for split(//, $word);
    return \%freq;
}

sub CC2(@words)
{
    return [] unless @words;

    my %letters = map { $_ => letterFreq($_) } @words;

    my $start = shift @words;
    my @result;

    for my $letter ( keys %{$letters{$start}} )
    {
        if ( all { ($letters{$_}{$letter} // 0) >= $letters{$start}{$letter} } @words )
        {
            push @result, $letter;
            $letters{$_}{$letter}-- for keys %letters;
        }
    }
    return \@result;
}

sub runTest
{
    use Test2::V0;

    is( CC2("java", "javascript", "julia"), ["j", "a"],      "Example 1");

    is( commonCharacters("java", "javascript", "julia"), ["j", "a"],      "Example 1");
    is( commonCharacters("bella", "label", "roller"),    ["e", "l", "l"], "Example 2");
    is( commonCharacters("cool", "lock", "cook"),        ["c", "o"],      "Example 3");

    is( commonCharacters("abc", "def", "xyz"),        [],       "No common");
    is( commonCharacters("ghi", "ghi", "ghi"), ["g", "h", "i"], "All common");
    is( commonCharacters("one"), ["o", "n", "e"], "One word");
    is( commonCharacters(), [], "Empty list");

    done_testing;
}
