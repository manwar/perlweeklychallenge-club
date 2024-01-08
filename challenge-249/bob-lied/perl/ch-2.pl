#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 249 Task 2 DI String Match
#=============================================================================
# You are given a string s, consisting of only the characters "D" and "I".
# Find a permutation of the integers [0 .. length(s)] such that for each
# character s[i] in the string:
# s[i] == 'I' ⇒ perm[i] < perm[i + 1]
# s[i] == 'D' ⇒ perm[i] > perm[i + 1]
# Example 1 Input: $str = "IDID"
#           Output: (0, 4, 1, 3, 2)
# Example 2 Input: $str = "III"
#           Output: (0, 1, 2, 3)
# Example 3 Input: $str = "DDI"
#           Output: (3, 2, 0, 1)
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

for my $DI ( @ARGV )
{
    next unless $DI =~ m/\A[ID]+\Z/;
    say "(", join(",", di($DI)->@*), ")";
}

sub di($s)
{
    my @perm;
    my @idx = 0 .. length($s);

    for my $di ( split("", $s) )
    {
        if   ( $di eq "I" ) { push @perm, shift @idx }
        else                { push @perm, pop   @idx }
    }
    push @perm, shift @idx;
    return \@perm;
}

sub runTest
{
    use Test2::V0;

    is(di("IDID"), [0,4,1,3,2], "Example 1");
    is(di("III"),  [0,1,2,3  ], "Example 2");
    is(di("DDI"),  [3,2,0,1  ], "Example 3");

    done_testing;
}
