#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 361 Task 1  Zeckendorf Representation
#=============================================================================
# You are given a positive integer (<= 100).  Write a script to return
# the Zeckendorf Representation of the given integer.  Every positive
# integer can be uniquely represented as sum of non-consecutive Fibonacci
# numbers. See https://en.wikipedia.org/wiki/Zeckendorf%27s_theorem
# Example 1 Input: $int = 4
#			Output: 3,1
# Example 2 Input: $int = 12
#			Output: 8,3,1
# Example 3 Input: $int = 20
#			Output: 13,5,2
# Example 4 Input: $int = 96
#			Output: 89,5,2
# Example 5 Input: $int = 100
#			Output: 89,8,3
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

say join(",", zeckendorf($_)->@*) for @ARGV;

#=============================================================================
sub zeckendorf($int)
{
    state @FIB = reverse ( 1, 2, 3, 5, 8, 13, 21, 34, 55, 89 );
    my @zeck;

    for ( my $i = 0; $int > 0 && $i < @FIB; $i++ )
    {
        my $f = $FIB[$i];
        next if $f > $int;
        $int -= $f;
        push @zeck, $f;
        $i++;
    }
    return \@zeck;
}

sub runTest
{
    use Test2::V0;

    is( zeckendorf(  4), [3,1],    "Example 1");
    is( zeckendorf( 12), [8,3,1],  "Example 2");
    is( zeckendorf( 20), [13,5,2], "Example 3");
    is( zeckendorf( 96), [89,5,2], "Example 4");
    is( zeckendorf(100), [89,8,3], "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
