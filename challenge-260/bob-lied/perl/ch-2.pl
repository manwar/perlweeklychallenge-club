#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 260 Task 2 Dictionary Rank
#=============================================================================
# You are given a word, $word.
# Write a script to compute the dictionary rank of the given word.
# Example 1 Input: $word = 'CAT'
#           Output: 3
#   All possible combinations of the letters:
#   CAT, CTA, ATC, TCA, ACT, TAC
#   Arrange them in alphabetical order:
#   ACT, ATC, CAT, CTA, TAC, TCA
#   CAT is the 3rd in the list.
#   Therefore the dictionary rank of CAT is 3.
#
# Example 2 Input: $word = 'GOOGLE'
#           Output: 88
# Example 3 Input: $word = 'SECRET'
#           Output: 255
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say dictOrder($_) for @ARGV;

sub dictOrder($word)
{
    use List::Permutor;

    my $perm = List::Permutor->new( sort { $a cmp $b } split(//, $word) );
    my $place = 0;
    my %seen; # Skip duplicate letters
    while ( my $p = join("", $perm->next()) )
    {
        next if $seen{$p};
        $place++;
        say "$place $p" if $Verbose;
        last if $p eq $word;
        $seen{$p} = true;
    }
    return $place;
}

sub runTest
{
    use Test2::V0;

    is( dictOrder("CAT"),      3, "Example 1");
    is( dictOrder("GOOGLE"),  88, "Example 2");
    is( dictOrder("SECRET"), 255, "Example 3");

    done_testing;
}
