#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 273 Task 2 B after A
#=============================================================================
# You are given a string, $str.
# Write a script to return true if there is at least one b, and no a
# appears after the first b.
# Example 1 Input: $str = "aabb" Output: true
# Example 2 Input: $str = "abab" Output: false
# Example 3 Input: $str = "aaa" Output: false
# Example 4 Input: $str = "bbb" Output: true
#=============================================================================

use v5.40;

use Getopt::Long;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say ( bAfterA($_) ? "true" : "false" ) for @ARGV;

sub bAfterA($str)
{
    my $w = index($str, "b");
    return $w >= 0 && index($str, "a", $w) < 0;
}

sub bAfterA_RE($str)
{
    $str =~ m/^[^b]*b[^a]*$/
}

sub runTest
{
    use Test2::V0;

    is (bAfterA("aabb"), true,  "Example 1");
    is (bAfterA("abab"), false, "Example 2");
    is (bAfterA("aaa" ), false, "Example 3");
    is (bAfterA("bbb" ), true,  "Example 4");

    is (bAfterA_RE("aabb"), true,  "Example 1 RE");
    is (bAfterA_RE("abab"), false, "Example 2 RE");
    is (bAfterA_RE("aaa" ), false, "Example 3 RE");
    is (bAfterA_RE("bbb" ), true,  "Example 4 RE");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese( $repeat, {
    index => sub{
        bAfterA("aabb"), bAfterA("abab"), bAfterA("aaaa"), bAfterA("bbbb"),
    },
    regex => sub{
        bAfterA_RE("aabb"), bAfterA_RE("abab"), bAfterA_RE("aaaa"), bAfterA_RE("bbbb"),
    },
    });
}
