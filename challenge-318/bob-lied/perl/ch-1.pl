#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 318 Task 1 Group Position
#=============================================================================
# You are given a string of lowercase letters.  Write a script to find the
# position of all groups in the given string. Three or more consecutive
# letters form a group. Return "” if none found.
# Example 1 Input: $str = "abccccd"
#           Output: "cccc"
# Example 2 Input: $str = "aaabcddddeefff"
#           Output: "aaa", "dddd", "fff"
# Example 3 Input: $str = "abcdd"
#           Output: ""
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

say '"', join('", "', groupPosition($_)->@*), '"' for @ARGV;

#=============================================================================
sub groupPosition($str)
{
    my @group;
    push @group, $1 while ( $str =~ m/((.)\2{2,})/g );
    return \@group;
}

sub runTest
{
    use Test2::V0;

    is( groupPosition("abccccd"),        [ "cccc"               ], "Example 1");
    is( groupPosition("aaabcddddeefff"), [ "aaa", "dddd", "fff" ], "Example 2");
    is( groupPosition("abcdd"),          [                      ], "Example 3");

    done_testing;
}
