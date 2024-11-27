#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 295 Task 2 Jump Game
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find the minimum number of jumps to reach the last
# element. $ints[$i] represents the maximum length of a forward jump from
# the index $i. In case last element is unreachable then return -1.
# Example 1 Input: @ints = (2, 3, 1, 1, 4)
#           Output: 2
#   Jump 1 step from index 0 then 3 steps from index 1 to the last element.
# Example 2 Input: @ints = (2, 3, 0, 4)
#           Output: 2
# Example 3 Input: @ints = (2, 0, 0, 4)
#           Output: -1
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say jumpGame(@ARGV);

sub jumpGame(@ints)
{
    my $last = $#ints;
    return 0 if $last == 0; # Handle a singular case.

    # Longest possible is to jump one place at a time.
    my $best = $last+1;

    # Depth-first search. Stack up possible positions and how many
    # jumps it took to get there. Use a hash for readability. Could
    # also use an array of two elements.
    my @stack = ( {at => 0, jump => 0} );
    while ( my $next = pop @stack )
    {
        my ($at, $jumpCount) = $next->@{qw(at jump)};

        # Optimization: give up if we can't beat the best score.
        next if $jumpCount >= $best;

        # If we can reach the end, we're done jumping.
        if ( ($at + $ints[$at]) >= $last )
        {
            $best = $jumpCount if ++$jumpCount < $best;
        }
        else
        {
            # Stack up each possible jump from here.
            push @stack, { at => $at+$_, jump => $jumpCount+1  } for 1 .. $ints[$at];
        }
    }
    return $best > $last ? -1 : $best;
}

# Array instead of hash is about 25% faster.
sub jg2($ints)
{
    my $last = $ints->$#*;
    return 0 if $last == 0; # Handle a singular case.

    my $best = $last+1;

    my @stack = ( [0,0] );
    while ( my $next = pop @stack )
    {
        my ($at, $jumpCount) = $next->@*;

        # Optimization: give up if we can't beat the best score.
        next if $jumpCount >= $best;

        # If we can reach the end, we're done jumping.
        if ( ($at + $ints->[$at]) >= $last && ++$jumpCount < $best )
        {
            $best = $jumpCount
        }
        else
        {
            # Stack up each possible jump from here.
            push @stack, [ $at + $_, $jumpCount+1 ] for 1 .. $ints->[$at];
        }
    }
    return $best > $last ? -1 : $best;
}

sub runTest
{
    use Test2::V0;

    is( jumpGame(0), 0, "Singularity 0");
    is( jumpGame(2), 0, "Singularity 2");

    is( jumpGame(1, 2),       1, "Done in 1");
    is( jumpGame(5, 0,0,0,0), 1, "Done in 1 longer");

    is( jumpGame(2,3,1,1,4),  2, "Example 1");
    is( jumpGame(2,3,0,4  ),  2, "Example 2");
    is( jumpGame(2,0,0,4  ), -1, "Example 3");

    is( jumpGame(1,1,1,1,1),  4, "One at at time");
    is( jumpGame(3,2,1,0,0), -1, "Never gets there");

    is( jg2([2,3,1,1,4]),  2, "Example 1 jg2");
    is( jg2([2,3,0,4  ]),  2, "Example 2 jg2");
    is( jg2([2,0,0,4  ]), -1, "Example 3 jg2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @ints  = map { int(rand(10)) } 1..50;

    cmpthese($repeat, {
            hash  => sub { jumpGame(@ints) },
            array => sub { jg2(\@ints) },
        });
}
