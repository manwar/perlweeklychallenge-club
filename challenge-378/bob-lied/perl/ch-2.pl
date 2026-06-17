#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 378 Task 2  Sum of Words
#=============================================================================
# You are given three strings consisting of lower case English letters
# ‘a’ to ‘j’ only. The letter value of a = 0, b = 1, c = 3, etc.
# Write a script to find if sum of first two strings return the third string.
# Example 1 Input: $str1 = "acb", $str2 = "cba", $str3 = "cdb"
#           Output: true
#   $str1 = "acb" = 021 $str2 = "cba" = 210 $str3 = "cdb" = 231
# Example 2 Input: $str1 = "aab", $str2 = "aac", $str3 = "ad"
#           Output: true
#   $str1 = "aab" = 001 $str2 = "aac" = 002 $str3 = "ad"  = 03
# Example 3 Input: $str1 = "bc", $str2 = "je", $str3 = "jg"
#           Output: false
#   $str1 = "bc" = 12 $str2 = "je" = 94 $str3 = "jg" = 96
# Example 4 Input: $str1 = "a", $str2 = "aaaa", $str3 = "aa"
#           Output: true
#   $str1 = "a"    = 0 $str2 = "aaaa" = 0000 $str3 = "aa"   = 00
# Example 5 Input: $str1 = "c", $str2 = "d", $str3 = "h"
#           Output: false
#   $str1 = "c" = 2 $str2 = "d" = 3 $str3 = "h" = 7
# Example 6 Input: $str1 = "gfi", $str2 = "hbf", $str3 = "bdhd"
#           Output: true
#   $str1 =  "gfi" =  658 $str2 =  "hbf" =  715 $str3 = "bdhd" = 1373
#=============================================================================

use v5.42;


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

say $_ for @ARGV;   # TODO command line processing here

#=============================================================================
sub task($str1, $str2, $str3)
{
    my @number = map { tr/a-j/0-9/r } $str1, $str2, $str3;

    return $number[0] + $number[1] == $number[2];
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(qw(cb cba cdb)),   true, "Example 1");
    is( task(qw(aab aac ad)),   true, "Example 2");
    is( task(qw(bc je jg)),    false, "Example 3");
    is( task(qw(a aaaa aa)),    true, "Example 4");
    is( task(qw(c d h)),       false, "Example 5");
    is( task(qw(gfi hbf bdhd)), true, "Example 6");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
