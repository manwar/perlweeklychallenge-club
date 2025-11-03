#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 346 Task 2  Magic Expression
#=============================================================================
# You are given a string containing only digits and a target integer.
# Write a script to insert binary operators +, - and * between the digits
# in the given string that evaluates to target integer.
# Example 1 Input: $str = "123", $target = 6
#           Output: ("1*2*3", "1+2+3")
# Example 2 Input: $str = "105", $target = 5
#           Output: ("1*0+5", "10-5")
# Example 3 Input: $str = "232", $target = 8
#           Output: ("2*3+2", "2+3*2")
# Example 4 Input: $str = "1234", $target = 10
#           Output: ("1*2*3+4", "1+2+3+4")
# Example 5 Input: $str = "1001", $target = 2
#           Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")
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

say '(', join(', ', magic(@ARGV)->@*), ')';

#=============================================================================
sub magic($str, $target)
{
    state @OP = ("", "-", "+", "*");
    $logger->debug("@OP");
    my @expr;
    return \@expr;
}

sub runTest
{
    use Test2::V0;

    is( magic("123",   6), ["1*2*3", "1+2+3"    ] , "Example 1");
    is( magic("105",   5), ["1*0+5", "10-5"     ] , "Example 2");
    is( magic("232",   8), ["2*3+2", "2+3*2"    ] , "Example 3");
    is( magic("1234", 10), ["1*2*3+4", "1+2+3+4"] , "Example 4");
    is( magic("1001",  2), ["1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"] , "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

