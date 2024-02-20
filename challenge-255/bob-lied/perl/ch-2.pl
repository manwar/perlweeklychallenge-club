#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 255 Task 2 Most Frequent Word
#=============================================================================
# You are given a paragraph $p and a banned word $w.
# Write a script to return the most frequent word that is not banned.
# Example 1
#   Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
#          $w = "hit"
#   Output: "ball"
#   The banned word "hit" occurs 3 times.
#   The other word "ball" occurs 2 times.
# Example 2
#   Input: $p = "Perl and Raku belong to the same family.
#                Perl is the most popular language in the weekly challenge."
#          $w = "the"
#   Output: "Perl"
#   The banned word "the" occurs 3 times.
#   The other word "Perl" occurs 2 times.
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Banned = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "banned:s" => \$Banned);
exit(!runTest()) if $DoTest;

say mfw( join("  ", @ARGV), $Banned);

sub mfw($p, $w)
{
    my %freq;
    $freq{$_}++ for ( split(" ", $p =~ s/[[:punct:]]+/ /gr) );
    delete $freq{$w};
    return (sort { $freq{$b} <=> $freq{$a} } keys %freq)[0];
}

sub runTest
{
    use Test2::V0;

    my $text;

    $text = <<E_N_D;
Joe hit a ball, the hit ball flew far after it was hit.
E_N_D
    is( mfw($text, "hit"), "ball", "Example 1");

    $text = <<E_N_D;
Perl and Raku belong to the same family.
Perl is the most popular language in the weekly challenge.
E_N_D
    is( mfw($text, "the"), "Perl", "Example 2");

    done_testing;
}
