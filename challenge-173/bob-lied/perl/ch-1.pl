#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 173 Task 1 Esthetic Number
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a positive integer, $n.
# Write a script to find out if the given number is Esthetic Number.
# An esthetic number is a positive integer where every adjacent digit
# differs from its neighbour by 1. For example,
# 5456 is an esthetic number as |5 - 4| = |4 - 5| = |5 - 6| = 1
# 120 is not an esthetic numner as |1 - 2| != |2 - 0| != 1
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

for my $N ( @ARGV )
{
    say "$N ", ( isEsthetic($N) ? "IS    " : "is not" ), " esthetic";
}

sub isEsthetic($n)
{
    my $isEth = true;

    my @d = split(//, $n);
    my $first = shift @d;
    while ( defined (my $next = shift @d) && $isEth )
    {
        $isEth &&= ( ($first - $next == 1) || ( $next - $first == 1 ) );
        $first = $next;
    }
    return $isEth;
}

sub runTest
{
    use Test2::V0;
    no warnings "experimental::builtin";

    is( isEsthetic(5456),  true, "Example 1");
    is( isEsthetic( 120), false, "Example 2");

    done_testing;
}

