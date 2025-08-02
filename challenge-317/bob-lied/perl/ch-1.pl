#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 317 Task 1 Acronyms
#=============================================================================
# You are given an array of words and a word.  Write a script to return
# true if concatenating the first letter of each word in the given array
# matches the given word, return false otherwise.
# Example 1 Input: @array = ("Perl", "Weekly", "Challenge") $word  = "PWC"
#           Output: true
# Example 2 Input: @array = ("Bob", "Charlie", "Joe") $word  = "BCJ"
#           Output: true
# Example 3 Input: @array = ("Morning", "Good") $word  = "MM"
#           Output: false
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

my $WORD = pop @ARGV;
say isAcro([@ARGV], $WORD) ? "true" : "false";

#=============================================================================
sub isAcro($array, $word)
{
    return $word eq join("", map { substr($_, 0, 1) } $array->@*);
}

sub runTest
{
    use Test2::V0;

    is( isAcro([qw/Perl Weekly Challenge/], "PWC"),  true, "Example 1");
    is( isAcro([qw/Bob Charlie Joe/],       "BCJ"),  true, "Example 2");
    is( isAcro([qw/Morning Good/],           "MM"), false, "Example 3");

    done_testing;
}
