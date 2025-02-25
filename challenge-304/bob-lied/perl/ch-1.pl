#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 304 Task 1 Arrange Binary
#=============================================================================
# You are given a list of binary digits (0 and 1) and a positive integer, $n.
# Write a script to return true if you can re-arrange the list by replacing at
# least $n digits with 1 in the given list so that no two consecutive digits
# are 1 otherwise return false.
# Example 1 Input: @digits = (1, 0, 0, 0, 1), $n = 1
#           Output: true
#   Re-arranged list: (1, 0, 1, 0, 1)
# Example 2 Input: @digits = (1, 0, 0, 0, 1), $n = 2
#           Output: false
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my $N = 1;

GetOptions("n:i" => \$N, "test" => \$DoTest,
            "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
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

say arrange($N, @ARGV) ? "true" : "false";

#=============================================================================
sub arrange($n, @digits)
{
    use List::Util qw/sum0/;
    my $possible = sum0 map { int(length($_)/2) }
            join("", 0,@digits) =~ m/(00+)(?!1)/g;
    return $n <= $possible;
}

sub runTest
{
    use Test2::V0;

    is( arrange(1,  1,0,0,0,1),    true, "Example 1");
    is( arrange(2,  1,0,1,0,1),   false, "Example 2");
    is( arrange(1,  0,0,1,1,1),    true, "Leading");
    is( arrange(1,  1,1,1,0,0),    true, "Trailing");
    is( arrange(2,  0,0,1,0,0),    true, "Leading and trailing");
    is( arrange(3,  0,0,1,0,0),   false, "Leading and trailing nope");
    is( arrange(3,  0,0,0,0,0,0),  true, "Even number of zeroes");
    is( arrange(4,  0,0,0,0,0,0), false, "Even number of zeroes no");
    is( arrange(1,            0),  true, "Degenerate single digit");
    is( arrange(2,            0), false, "Degenerate single digit no");
    is( arrange(1,          0,0),  true, "Degenerate two digit");
    is( arrange(2,          0,0), false, "Degenerate two digit 2");
    is( arrange(1,          1,0), false, "Degenerate two digit no");

    is( arrange(2,  1,0,0,1,0,0,1),false, "Only pairs");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
