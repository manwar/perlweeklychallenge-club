#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 371 Task 2  Subset Equilibrium
#=============================================================================
# You are given an array of numbers.  Write a script to find all subsets
# where the sum of elements equals the sum of their indices.
#
# Example 1 Input: @nums = (2, 1, 4, 3)
#			Output: (2, 1), (1, 4), (4, 3), (2, 3)
#   Subset 1: (2, 1) Values: 2 + 1 = 3 Positions: 1 + 2 = 3
#   Subset 2: (1, 4) Values: 1 + 4 = 5 Positions: 2 + 3 = 5
#   Subset 3: (4, 3) Values: 4 + 3 = 7 Positions: 3 + 4 = 7
#   Subset 4: (2, 3) Values: 2 + 3 = 5 Positions: 1 + 4 = 5
#
# Example 2 Input: @nums = (3, 0, 3, 0)
#			Output: (3, 0), (3, 0, 3)
#   Subset 1: (3, 0) Values: 3 + 0 = 3 Positions: 1 + 2 = 3
#   Subset 2: (3, 0, 3) Values: 3 + 0 + 3 = 6 Positions: 1 + 2 + 3 = 6
#
# Example 3 Input: @nums = (5, 1, 1, 1)
#			Output: (5, 1, 1)
#   Subset 1: (5, 1, 1) Values: 5 + 1 + 1 = 7 Positions: 1 + 2 + 4 = 7
#
# Example 4 Input: @nums = (3, -1, 4, 2)
#			Output: (3, 2), (3, -1, 4)
#   Subset 1: (3, 2) Values: 3 + 2 = 5 Positions: 1 + 4 = 5
#   Subset 2: (3, -1, 4) Values: 3 + (-1) + 4 = 6 Positions: 1 + 2 + 3 = 6
#
# Example 5 Input: @nums = (10, 20, 30, 40)
#			Output: ()
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

say join ", ", map { "(" . join(", ", $_->@*) . ")" } sseq(@ARGV)->@*;

#=============================================================================
sub sseq(@nums)
{
    use Algorithm::Combinatorics qw/subsets/;
    use List::Util qw/sum0/;
    my @result;

    my $s = subsets( [0 .. $#nums] );
    while ( my $position = $s->next() )
    {
        # Only proper subsets of size 2 or more
        my $size = scalar(@$position);
        next if $size == scalar(@nums) || $size < 2;

        # Subsets are indexed at zero, but positions at 1, so compensate in sum
        my $sumPosition = $size + sum0  $position->@*;

        my $sumNumbers = sum0 @nums[ @$position ];
        $logger->debug("Positions: (@$position) num=$sumNumbers pos=$sumPosition");

        if ( $sumNumbers == $sumPosition )
        {
            $logger->debug("RESULT $sumNumbers num[@$position] = (@nums[@$position])");
            push @result, [@nums[@$position]]
        }
    }
    return \@result;
}


sub runTest
{
    use Test2::V0;
    use Test2::Tools::Compare qw/bag item/;
    my $check;

    $check = bag { item [1,4]; item [2,1]; item [2,3]; item [4,3]; end(); };
    is( sseq(2,1,4,3), $check, "Example 1");

    $check = bag { item [3,0]; item [3,0,3]; end() };
    is( sseq(3,0,3,0),  $check, "Example 2");

    $check = bag { item [5,1,1]; end() };
    is( sseq(5,1,1,1),  $check, "Example 3");

    $check = bag { item [3,2]; item [3,-1,4]; end() };
    is( sseq(3,-1,4,2), $check, "Example 4");

    is( sseq(10, 20, 30, 40), [], "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

