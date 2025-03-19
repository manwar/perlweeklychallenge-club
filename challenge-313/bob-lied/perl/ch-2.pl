#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 313 Task 2 Reverse Letters
#=============================================================================
# You are given a string.
# Write a script to reverse only the alphabetic characters in the string.
# Example 1 Input: $str = "p-er?l"
#           Output: "l-re?p"
# Example 2 Input: $str = "wee-k!L-y"
#           Output: "yLk-e!e-w"
# Example 3 Input: $str = "_c-!h_all-en!g_e"
#           Output: "_e-!g_nel-la!h_c"
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

say reverseLetter($_) for @ARGV;

#=============================================================================
sub reverseLetter($str)
{
    my @alpha = ($str =~ m/[[:alpha:]]/g);
    $str =~ s/[[:alpha:]]/pop @alpha/ger;
}

sub runTest
{
    use Test2::V0;

    is( reverseLetter("p-er?l"),           "l-re?p",           "Example 1");
    is( reverseLetter("wee-k!L-y"),        "yLk-e!e-w",        "Example 2");
    is( reverseLetter("_c-!h_all-en!g_e"), "_e-!g_nel-la!h_c", "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
