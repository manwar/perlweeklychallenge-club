#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 215 Task 1 Odd One Out 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of words (alphabetic characters only) of same size.
# Write a script to remove all words not sorted alphabetically and print the
# number of words in the list that are not alphabetically sorted.
# Example 1 Input: @words = ('abc', 'xyz', 'tsu') Output: 1
# Example 2 Input: @words = ('rat', 'cab', 'dad') Output: 3
# Example 3 Input: @words = ('x', 'y', 'z') Output: 0
#=============================================================================

use v5.36;

use builtin qw/true false/; no warnings "experimental::builtin";

binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say oddOneOut(@ARGV);

sub isOrdered($word)
{
    use Unicode::Collate;
    state $Collator = Unicode::Collate->new();

    my @char = split(//, lc($word));
    my $first = shift @char;
    while ( my $next = shift @char )
    {
        return false if $Collator->gt($first, $next) > 0;
        $first = $next;
    }
    return true;
}

sub oddOneOut(@words)
{
    use List::Util qw/all/;

    return 0 unless @words;
    my $wordLength = length($words[0]);
    return 0 unless all { length($_) == $wordLength } @words;

    my $removeCount = grep { not isOrdered($_) } @words;

    return $removeCount;
}

sub runTest
{
    use Test2::V0;

    is(oddOneOut(               ), 0, "Empty list");
    is(oddOneOut('', '', ''     ), 0, "Empty strings");
    is(oddOneOut(qw(xyzz       )), 0, "One word sorted");
    is(oddOneOut(qw(xyzzy      )), 1, "One word out");
    is(oddOneOut(qw(abc xyz tsu)), 1, "Example 1");
    is(oddOneOut(qw(rat cab dad)), 3, "Example 2");
    is(oddOneOut(qw(x   y   z  )), 0, "Example 3");
    is(oddOneOut(qw(xyz de  m  )), 0, "Different lengths");
    is(oddOneOut(qw(mío año del)), 1, "Spanish");

    done_testing;
}

