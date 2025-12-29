#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 354 Task 1  Min Abs Diff
#=============================================================================
# You are given an array of distinct integers. Write a script to find all
# pairs of elements with the minimum absolute difference.
# Rules (a,b):
#   1: a, b are from the given array.
#   2: a < b
#   3: b - a = min abs diff any two elements in the given array
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

say join(", ", map { "[$_->[0], $_->[1]]" } minAbsDiff(@ARGV)->@* );

#=============================================================================
sub minAbsDiff(@ints)
{
    my %diff;
    my $min = abs($ints[0] - $ints[1]);

    # Sort to get the ordering required
    @ints = sort { $a <=> $b } @ints;

    while ( defined(my $first = shift @ints) )
    {
        for my $second ( @ints )
        {
            my $d = $second - $first;   # Sorted, so must be positive
            $min = $d if $d < $min;

            # If it can't be part of solution, save space and time. Differences
            # will only get larger because the list is sorted.
            last if $d > $min;

            push @{$diff{$d}}, [$first, $second];
        }
    }
    return $diff{$min};
}

sub runTest
{
    use Test2::V0;

    is( minAbsDiff( 4,   2,  1,  3    ), [[ 1,  2], [ 2,  3], [3, 4]], "Example 1");
    is( minAbsDiff(10, 100, 20, 30    ), [[10, 20], [20, 30]        ], "Example 2");
    is( minAbsDiff(-5,  -2,  0,  3    ), [[-2,  0]                  ], "Example 3");
    is( minAbsDiff( 8,   1, 15,  3    ), [[ 1,  3]                  ], "Example 4");
    is( minAbsDiff(12,   5,  9,  1, 15), [[ 9, 12], [12, 15]        ], "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

