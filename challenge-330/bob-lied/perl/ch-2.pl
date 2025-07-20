#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 330 Task 2  Title Capital
#=============================================================================
# You are given a string made up of one or more words separated by a single
# space. Write a script to capitalise the given title. If the word length is
# 1 or 2 then convert the word to lowercase otherwise make the first
# character uppercase and remaining lowercase.
# Example 1 Input: $str = "PERL IS gREAT"
#           Output: "Perl is Great"
# Example 2 Input: $str = "THE weekly challenge"
#           Output: "The Weekly Challenge"
# Example 3 Input: $str = "YoU ARE A stAR"
#           Output: "You Are a Star"
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

say capTitle($_) for @ARGV;

#=============================================================================
sub capTitle($str)
{
    join(" ", map { length($_) > 2 ? ucfirst($_) : $_ } split(/ /, lc($str) ));
}

sub runTest
{
    use Test2::V0;

    is( capTitle("PERL IS gREAT"       ), "Perl is Great",        "Example 1");
    is( capTitle("THE weekly challenge"), "The Weekly Challenge", "Example 2");
    is( capTitle("YoU ARE A sTAR"      ), "You Are a Star",       "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
