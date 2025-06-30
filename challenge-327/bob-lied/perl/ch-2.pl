#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 327 Task 2  MAD
#=============================================================================
# You are given an array of distinct integers.  Write a script to find all
# pairs of elements with minimum absolute difference (MAD) of any two elements.
# Example 1 Input: @ints = (4, 1, 2, 3)
#           Output: [1,2], [2,3], [3,4]
#   The minimum absolute difference is 1.  Pairs with MAD: [1,2], [2,3], [3,4]
# Example 2 Input: @ints = (1, 3, 7, 11, 15)
#           Output: [1,3]
# Example 3 Input: @ints = (1, 5, 3, 8)
#           Output: [1,3], [3,5]
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

say join ", ", map { "[$_->[0],$_[1]]" } mad(@ARGV);

#=============================================================================
sub mad(@ints)
{
    use List::Util qw/max/;

    my $mindiff = max @ints;
    @ints = sort { $a <=> $b } @ints;
    my @diff;
    for my $i ( 1 .. $#ints )
    {
        my $d = $diff[$i] = abs( $ints[$i] - $ints[$i-1] );
        $mindiff = $d if $d < $mindiff;
    }
    return [ map { [ $ints[$_-1], $ints[$_] ] }
                grep { $diff[$_] == $mindiff } 1 .. $#ints ];
}

sub runTest
{
    use Test2::V0;

    is( mad(4,1,2,3),     [ [1,2], [2,3], [3,4] ], "Example 1");
    is( mad(1,3,7.11,15), [ [1,3]               ], "Example 2");
    is( mad(1,5,3,8),     [ [1,3], [3,5]        ], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
