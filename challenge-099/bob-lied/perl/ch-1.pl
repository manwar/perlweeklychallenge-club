#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
#  Perl Weekly Challeng 99, TASK #1 › Pattern Match
# You are given a string $S and a pattern $P.
# Write a script to check if given pattern validate the entire string.
# Print 1 if pass otherwise 0.
# The patterns can also have the following characters:
# ? - Match any single character.
# * - Match any sequence of characters. 
#=============================================================================

use strict;
use warnings;
use 5.020;
use experimental qw/ signatures /;

use Getopt::Long;
my $doTest;
GetOptions("test" => \$doTest);
exit(!runTest()) if $doTest;

sub Usage { "$0 'string' 'pattern'" }

my $S = shift;
my $P = shift;
die Usage() unless $S;
die Usage() unless $P;

say patternMatch($S, $P);

sub patternMatch($s, $p)
{
    # Convert glob metacharacters to regex equivalents.
    $p =~ s/\*+/.*/g;
    $p =~ s/\?/./g;

    # Anchor to match whole string.  Use /s to match embedded newlines.
    return $s =~ m/^$p$/s || 0;
}

sub runTest
{
    use Test::More;

    is( patternMatch("abcde", "a*e"),     1);
    is( patternMatch("abcde", "a*d"),     0);
    is( patternMatch("abcde", "?b*d"),    0);
    is( patternMatch("abcde", "a*c?e"),   1);
    is( patternMatch("ab\nde", "ab?de"),  1);
    is( patternMatch("ab\nde", "ab*de"),  1);

    done_testing;
}
