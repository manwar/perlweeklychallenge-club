#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 316 Task 1 Circular 
#=============================================================================
# You are given a list of words. Write a script to find out whether the last
# character of each word is the first character of the following word.
# Example 1 Input: @list = ("perl", "loves", "scala")
#           Output: true
# Example 2 Input: @list = ("love", "the", "programming")
#           Output: false
# Example 3 Input: @list = ("java", "awk", "kotlin", "node.js")
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

say circular(@ARGV) ? "true" : "false";

#=============================================================================
sub circular(@list)
{
    my $first = shift @list;
    while ( defined(my $second = shift @list) )
    {
        return false if substr($first, -1, 1) ne substr($second, 0, 1);
        $first = $second;
    }
    return true;
}

sub runTest
{
    use Test2::V0;

    is( circular( qw/perl loves scalar/    ),  true, "Example 1");
    is( circular( qw/love the programming/ ), false, "Example 2");
    is( circular( qw/java awk kotlin node/ ),  true, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
