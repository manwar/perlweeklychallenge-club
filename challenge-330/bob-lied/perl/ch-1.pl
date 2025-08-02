#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 330 Task 1  Clear Digits
#=============================================================================
# You are given a string containing only lower case English letters and
# digits. Write a script to remove all digits by removing the first digit
# and the closest non-digit character to its left.
# Example 1 Input: $str = "cab12"
#           Output: "c"
#   Round 1: remove "1" then "b" => "ca2"
#   Round 2: remove "2" then "a" => "c"
# Example 2 Input: $str = "xy99"
#           Output: ""
# Example 3 Input: $str = "pa1erl"
#           Output: "perl"
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

say clearDigits($_) for @ARGV;

#=============================================================================
sub clearDigits($str)
{
    while ( $str =~ s/(?:^|[a-z])[0-9]//g ) { }
    return $str;
}

sub runTest
{
    use Test2::V0;

    is( clearDigits("cab12" ), "c",    "Example 1");
    is( clearDigits("xy99"  ), "",     "Example 2");
    is( clearDigits("pa1erl"), "perl", "Example 3");

    is( clearDigits("7abc"),   "abc", "Starts with digits");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
