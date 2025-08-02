#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 255 Task 1 Odd Character
#=============================================================================
# You are given two strings, $s and $t. The string $t is generated using
# the shuffled characters of the string $s with an additional character.
# Write a script to find the additional character in the string $t.
# Example 1 Input: $s = "Perl" $t = "Preel" Output: "e"
# Example 2 Input: $s = "Weekly" $t = "Weeakly" Output: "a"
# Example 3 Input: $s = "Box" $t = "Boxy" Output: "y"
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say oddChar(@ARGV[0, 1]);

sub oddChar($s, $t)
{
    my %freq;
    $freq{$_}++ for split(//, $s);
    $freq{$_}-- for split(//, $t);

    my @remain = grep { $freq{$_} != 0 } keys %freq;
    if ( @remain > 1 )
    {
        die "Too many differences $s => $t, [@remain]"
    }
    elsif ( @remain == 0 )
    {
        die "No difference between $s and $t"
    }
    elsif ( $freq{$remain[0]} != -1 )
    {
        die "Not exactly one diff for @remain"
    }
    return $remain[0];
}

sub oddChar2($s, $t)
{
    die qq("$t" has wrong length compared to "$s")
        if length($t) != length($s)+1;

    for my $c ( split(//, $t) )
    {
        if ( ( my $i = index($s, $c) ) < 0 )
        {
            return $c;
        }
        else
        {
            substr($s, $i, 1) = "";
        }
    }
}

sub runTest
{
    use Test2::V0;

    is( oddChar("Perl",   "Preel"),   "e", "Example 1");
    is( oddChar("Weekly", "Weeakly"), "a", "Example 2");
    is( oddChar("Box",    "Boxy"),    "y", "Example 3");

    like(
        dies { oddChar("xyzzy","xyzzy") }, qr/No difference/,
        "Dies if no difference");
    like(
        dies { oddChar("xyzzy","plover") }, qr/Too many/,
        "Dies if too many differences");
    like(
        dies { oddChar("xyzzy","xyzzyAA") }, qr/exactly one/,
        "Dies if more than one of diff");

    done_testing;
}
