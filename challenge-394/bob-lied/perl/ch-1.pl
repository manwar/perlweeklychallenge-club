#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 394 Task 1  Alternate Case
#=============================================================================
# You are given a string containing an equal number of uppercase and lowercase
# English letters.  Write a script to the minimum number of adjacent character
# swaps needed to turn the given string into an alternate case string.
# Example 1 Input: $str = "aAbB" Output: 0
# Example 2 Input: $str = "AAbb" Output: 1
# Example 3 Input: $str = "AAAbbb" Output: 3
# Example 4 Input: $str = "aABb" Output: 1
# Example 5 Input: $str = "bBBAaa" Output: 2
#=============================================================================

use v5.44;


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
    my $count = 0;
    while ( $str =~ m/[[:lower:]][[:lower:]]|[[:upper:]][[:upper:]]/ )
    {
        $count += $str =~ s/([[:upper:]])([[:upper:]])([[:lower:]])/$1$3$2/g;
        $count += $str =~ s/([[:lower:]])([[:lower:]])([[:upper:]])/$1$3$2/g;
        $count += $str =~ s/([[:lower:]])([[:upper:]])([[:upper:]])/$2$1$3/g;
        $count += $str =~ s/([[:upper:]])([[:lower:]])([[:lower:]])/$2$1$3/g;
    }
    return $count;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(  "aAbB"), 0, "Example 1");
    is( task(  "AAbb"), 1, "Example 2");
    is( task("AAAbbb"), 3, "Example 3");
    is( task(  "aABb"), 1, "Example 4");
    is( task("bBBAaa"), 2, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
