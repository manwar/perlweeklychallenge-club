#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 274 Task 1 Goat Latin
#=============================================================================
# You are given a sentence, $sentance.
# Write a script to convert the given sentence to Goat Latin, a made up
# language similar to Pig Latin.
# Rules for Goat Latin:
# 1) If a word begins with a vowel ("a", "e", "i", "o", "u"),
#    append "ma" to the end of the word.
# 2) If a word begins with consonant i.e. not a vowel, remove first
#    letter and append it to the end then add "ma".
# 3) Add letter "a" to the end of first word in the sentence, "aa" to
#    the second word, etc etc.
#
# Example 1 Input: $sentence = "I love Perl"
#           Output: "Imaa ovelmaaa erlPmaaaa"
# Example 2 Input: $sentence = "Perl and Raku are friends"
#           Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"
# Example 3 Input: $sentence = "The Weekly Challenge"
#           Output: "heTmaa eeklyWmaaa hallengeCmaaaa"
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub goatLatin($sentence)
{
    my $maa = 'ma';
    join ' ',
        map { s/^([^aeiou]?)(.*)$/$2$1/ir  .  ($maa .= 'a') }
        split /\W+/, $sentence
}

sub runTest
{
    use Test2::V0;

    is( goatLatin("I love Perl"),
                  "Imaa ovelmaaa erlPmaaaa", "Example 1");
    is( goatLatin("Perl and Raku are friends"),
                  "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa",
                  "Example 2");
    is( goatLatin("The Weekly Challenge"),
                  "heTmaa eeklyWmaaa hallengeCmaaaa", "Example 3");

    done_testing;
}
