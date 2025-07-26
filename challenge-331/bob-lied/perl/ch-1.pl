#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 331 Task 1  Last Word
#=============================================================================
# You are given a string.
# Write a script to find the length of last word in the given string.
# Example 1 Input: $str = "The Weekly Challenge"
#           Output: 9
# Example 2 Input: $str = "   Hello   World    "
#           Output: 5
# Example 3 Input: $str = "Let's begin the fun"
#           Output: 3
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

say lastWord("@ARGV");

#=============================================================================
sub lastWord($str)
{
    my $last = (split(/ /, $str))[-1] // "";
    $last =~ s/[[:punct:]]+$//;
    $last =~ s/^[[:punct:]]+//;
    return length($last);
}

sub runTest
{
    use Test2::V0;

    is( lastWord("The Weekly Challenge"), 9, "Example 1");
    is( lastWord("   Hello   World    "), 5, "Example 2");
    is( lastWord("Let's begin the fun"),  3, "Example 3");

    is( lastWord(""), 0, "Empty string");
    is( lastWord("word"), 4, "One word");

    is( lastWord("The ('dogs)'?"), 4, "Surrounded by punctation");
    is( lastWord("What abous the dog's"), 5, "Possessive/contraction");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
