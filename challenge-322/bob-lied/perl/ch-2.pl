#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 322 Task 2 Rank Array
#=============================================================================
# You are given an array of integers.  Write a script to return an array
# of the ranks of each element: the lowest value has rank 1, next lowest
# rank 2, etc. If two elements are the same then they share the same rank.
# Example 1 Input: @ints = (55, 22, 44, 33)
#           Output: (4, 1, 3, 2)
# Example 2 Input: @ints = (10, 10, 10)
#           Output: (1, 1, 1)
# Example 3 Input: @ints = (5, 1, 1, 4, 3)
#           Output: (4, 1, 1, 3, 2)
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

say '(', join(',', rankArray(@ARGV)), ')';

#=============================================================================
sub rankArray(@ints)
{
    my @sorted = sort { $a <=> $b } @ints;
    my %rank;
    my $r = 1;
    $rank{$_} //= $r++ for ( @sorted );
    return [ map { $rank{$_} } @ints ];
}

sub runTest
{
    use Test2::V0;

    is( rankArray(55,22,44,33), [4,1,3,2  ], "Example 1");
    is( rankArray(10,10,10   ), [1,1,1    ], "Example 2");
    is( rankArray(5,1,1,4,3  ), [4,1,1,3,2], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
