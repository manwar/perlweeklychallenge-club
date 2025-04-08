#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 316 Task 2 Subsequence
#=============================================================================
# You are given two strings. Write a script to find out if one string is a
# subsequence of another. A subsequence of a string is a new string that is
# formed from the original string by deleting some (can be none) of the
# characters without disturbing the relative positions of the remaining
# characters.
# Example 1 Input: $str1 = "uvw", $str2 = "bcudvew"
#           Output: true
# Example 2 Input: $str1 = "aec", $str2 = "abcde"
#           Output: false
# Example 3 Input: $str1 = "sip", $str2 = "javascript"
#           Output: true
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say subseq(@ARGV) ? "true" : "false";

#=============================================================================
sub subseq($str1, $str2)
{
    my @seq = split(//, $str1);
    my $where = index($str2, shift @seq);
    while ( @seq && $where >= 0 )
    {
        $where = index($str2, shift @seq, $where+1)
    }
    return $where >= 0;
}

sub runTest
{
    use Test2::V0;

    is( subseq("uvw", "bcudvew"   ),  true, "Example 1");
    is( subseq("aec", "abcde"     ), false, "Example 2");
    is( subseq("sip", "javascript"),  true, "Example 3");

    is( subseq("aaaaa", "xyza"),  false, "Longer than string with a match");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
