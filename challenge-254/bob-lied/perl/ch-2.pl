#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 254 Task 2 Reverse Vowels
#=============================================================================
# You are given a string, $s.  Write a script to reverse all the vowels
# (a, e, i, o, u) in the given string.
# Example 1 Input: $s = "Raku"  Output: "Ruka"
# Example 2 Input: $s = "Perl"  Output: "Perl"
# Example 3 Input: $s = "Julia" Output: "Jaliu"
# Example 4 Input: $s = "Uiua"  Output: "Auiu"
#=============================================================================

use v5.38;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say revVow($_) for @ARGV;

sub revVow($s)
{
    state $isVowel = qr/[aeiou]/i;

    my @v = $s =~ m/$isVowel/g;
    my $rev;
    for ( split(//, $s) )
    {
        my $next = ( /$isVowel/ ? pop @v : $_ );
        $rev .= ( /\p{Uppercase}/ ? uc $next : lc $next );
    }
    return $rev;
}

sub runTest
{
    use Test2::V0;

    is( revVow("Raku"),  "Ruka",  "Example 1");
    is( revVow("Perl"),  "Perl",  "Example 2");
    is( revVow("Julia"), "Jaliu", "Example 3");
    is( revVow("Uiua"),  "Auiu",  "Example 4");
    is( revVow("AEIOU"), "UOIEA", "Odd length");
    is( revVow("aEiOu"), "uOiEa", "Retain casing 1");
    is( revVow("AeIo"),  "OiEa", "Retain casing 2");

    done_testing;
}
