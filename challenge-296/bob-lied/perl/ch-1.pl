#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 296 Task 1 String Compression
#=============================================================================
# You are given a string of alphabetic characters, $chars.
# Write a script to compress the string with run-length encoding, as shown
# in the examples.  A compressed unit can be either a single character or a
# count followed by a character.
# BONUS: Write a decompression function.
#
# Example 1 Input: $chars = "abbc"
#           Output: "a2bc"
# Example 2 Input: $chars = "aaabccc"
#           Output: "3ab3c"
# Example 3 Input: $chars = "abcc"
#           Output: "ab2c"
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say rle_enc($_) for @ARGV;

sub rle_enc($str)
{
    my @s = split(//, $str);

    my $out = "";
    while ( defined(my $c = shift @s) )
    {
        my $n = 1;
        while ( @s && $s[0] eq $c ) { $n++; shift @s; }
        $out .= ( $n>1 ? $n : "" ) . $c;
    }

    return $out;
}

sub rle_dec($str)
{
    my $out;
    while ( length($str) > 0 )
    {
        my $n = ( ( $str =~ s/^(\d+)// ) ? $1 : 1 );
        $out .= (substr($str, 0, 1, '') x $n);
    }
    return $out;
}

sub runTest
{
    use Test2::V0;

    is( rle_enc("abbc"),    "a2bc",  "Example 1 encode");
    is( rle_enc("aaabccc"), "3ab3c", "Example 2 encode");
    is( rle_enc("abcc"),    "ab2c",  "Example 3 encode");

    is( rle_dec("a2bc"),    "abbc",    "Example 1 decode");
    is( rle_dec("3ab3c"),   "aaabccc", "Example 2 decode");
    is( rle_dec("ab2c"),    "abcc",    "Example 3 decode");

    is( rle_enc("rrrrrrrrrrr"), "11r", "Double digits encode");
    is( rle_dec("11r"), "rrrrrrrrrrr", "Double digits decode");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
