#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 266 Task 1 Uncommon Words
#=============================================================================
# You are given two sentences, $line1 and $line2.
# Write a script to find all uncommmon words in any order in the given two
# sentences. Return ('') if none found.
# A word is uncommon if it appears exactly once in one of the sentences
# and doesn’t appear in other sentence.
# Example 1 Input: $line1 = 'Mango is sweet'
#                  $line2 = 'Mango is sour'
#           Output: ('sweet', 'sour')
# Example 2 Input: $line1 = 'Mango Mango'
#                  $line2 = 'Orange'
#           Output: ('Orange')
# Example 3 Input: $line1 = 'Mango is Mango'
#                  $line2 = 'Orange is Orange'
#           Output: ('')
#=============================================================================

use v5.38;

use builtin qw/true false trim/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ", map { "'$_'" } uncommon(@ARGV)->@* ), ")";


sub uncommon(@sentenceList)
{
    use Text::ParseWords;
    use List::MoreUtils qw/frequency/;
    my @words = grep { defined } quotewords( '\W+', false, @sentenceList);

    my %freq = frequency(@words);
    my @uncommon = grep { $freq{$_} == 1 } keys %freq;
    return @uncommon ? [  sort @uncommon ] : [ '' ];
}

sub runTest
{
    use Test2::V0;

    is( uncommon("Mango is sweet", "Mango is sour"), [ qw(sour sweet) ], "Example 1");
    is( uncommon("Mango Mango", "Orange"), [ 'Orange' ], "Example 2");
    is( uncommon("Mango is Mango", "Orange is Orange"), [ '' ], "Example 3");

    done_testing;
}
