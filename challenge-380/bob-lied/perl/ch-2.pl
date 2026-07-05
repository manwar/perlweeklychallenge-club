#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 380 Task 2  Reverse Degree
#=============================================================================
# You are given a string.  Write a script to find the reverse degree of the
# given string.  For each character, multiply its position in the reversed
# alphabet (‘a’ = 26, ‘b’ = 25, …, ‘z’ = 1) with its position in the string.
# Sum these products for all characters in the string to get the reverse degree.
# Example 1 Input: $str = "z"
#           Output: 1
#   Reverse alphabet value of "z" is 1.  Position 1: 1 x 1 Sum of product: 1
# Example 2 Input: $str = "a"
#           Output: 26
#   Reverse alphabet value of "a" is 26.  Position 1: 1 x 26 Sum of product: 26
# Example 3 Input: $str = "bbc"
#           Output: 147
#   (1 X 25) + (2 X 25) + (3 + 24) = 25 + 50 + 72 = 147
# Example 4 Input: $str = "racecar"
#           Output: 560
# Example 5 Input: $str = "zyx"
#           Output: 14
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

say task($_) for @ARGV;

#=============================================================================
sub task($str)
{
    state $ZED = ord('z') + 1;

    $str = ( lc($str) =~ tr/a-z//cdr );

    my $degree = 0;
    for my ($i, $d) ( indexed map { $ZED - ord($_) } split(//, $str) )
    {
        $degree += ($i+1) * $d;
    }
    return $degree;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("z"),         1, "Example 1");
    is( task("a"),        26, "Example 2");
    is( task("bbc"),     147, "Example 3");
    is( task("racecar"), 560, "Example 4");
    is( task("zyx"),      14, "Example 5");
    is( task("xyz"), task("XYZ"), "Case independent");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
