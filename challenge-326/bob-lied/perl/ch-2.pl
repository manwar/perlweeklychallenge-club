#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 326 Task 2  Decompressed List
#=============================================================================
# You are given an array of positive integers having even elements.
# Write a script to to return the decompress list. To decompress, pick
# adjacent pair (i, j) and replace it with j, i times.
# Example 1 Input: @ints = (1, 3, 2, 4)
#           Output: (3, 4, 4)
#   Pair 1: (1, 3) => 3 one time  => (3)
#   Pair 2: (2, 4) => 4 two times => (4, 4)
# Example 2 Input: @ints = (1, 1, 2, 2)
#           Output: (1, 2, 2)
# Example 3 Input: @ints = (3, 1, 3, 2)
#           Output: (1, 1, 1, 2, 2, 2)
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

say decompress(@ARGV);

#=============================================================================
sub decompress(@ints)
{
    my @output;
    for my ($repeat, $value) ( @ints )
    {
        push @output, ($value) x $repeat;
    }

    return \@output;
}

sub runTest
{
    use Test2::V0;

    is( decompress(1,3,2,4), [3,4,4],       "Example 1");
    is( decompress(1,1,2,2), [1,2,2],       "Example 2");
    is( decompress(3,1,3,2), [1,1,1,2,2,2], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
