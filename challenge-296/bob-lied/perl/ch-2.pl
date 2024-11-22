#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 296 Task 2 Matchstick Square
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find if it is possible to make one square using the
# sticks as in the given array @ints where $ints[ì] is the length of ith stick.
# Example 1 Input: @ints = (1, 2, 2, 2, 1)
#           Output: true
#   Top: $ints[1] = 2
#   Bottom: $ints[2] = 2
#   Left: $ints[3] = 2
#   Right: $ints[0] and $ints[4] = 2
# Example 2 Input: @ints = (2, 2, 2, 4)
#           Output: false
# Example 3 Input: @ints = (2, 2, 2, 2, 4)
#           Output: false
# Example 4 Input: @ints = (3, 4, 1, 4, 3, 1)
#           Output: true
#=============================================================================

use v5.40;

use List::Util qw/any sum0/;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say canSquare(@ARGV) ? "true" : "false";

sub canSquare(@ints)
{
    return false if @ints < 4;
    my $perimeter = sum0(@ints);
    return false unless $perimeter && ($perimeter % 4) == 0;
    my $side = $perimeter / 4;

    # If any piece is too long, can't make a square of it.
    return false if any { $_ > $side } @ints;

    # Depth-first search to find a combo that makes a square.
    my $currentTarget = $side;
    my @target = ( 2*$side, 3*$side, 4*$side );

    my $isSquare = false;
    my @stack = ( [ 0, [ @ints ], [] ] );
    SIDE: while ( my $next = pop @stack )
    {
        my ($len, $avail, $path) = $next->@*;

        if ( not defined $currentTarget )
        {
            $isSquare = true if @$avail == 0;
            last SIDE;
        }

        for my ($i, $m) ( indexed $avail->@* )
        {
            my $length = $len + $m;
            if ( $Verbose ) {
                say scalar(@stack), " targ=$currentTarget len=$len m=$m avail=[$avail->@*] path=[$path->@* $m]";
            }
            next if $length > $currentTarget;

            my @copy = $avail->@*;
            if ( $Verbose ) {
                splice(@copy, $i, 1, "X");
                say scalar(@stack), " push stack, [ $length, [@copy], [$path->@* $m] ";
            }
            splice(@copy, $i, 1);
            push @stack, [ $length, [ @copy ], [ $path->@*, $m ] ];


            if ( $length == $currentTarget )
            {
                # Completed a side
                if ( $Verbose ) { say "SIDE COMPLETE: $currentTarget" }
                $currentTarget = shift @target;
                last;
            }
        }
    }

    return $isSquare;
}

sub runTest
{
    use Test2::V0;

    is( canSquare(1,2,2,2,1),    true, "Example 1");
    is( canSquare(2,2,2,4),     false, "Example 2");
    is( canSquare(2,2,2,2,4),   false, "Example 3");
    is( canSquare(3,4,1,4,3,1),  true, "Example 4");

    is( canSquare(7,7,7,7,4),   false, "Math is right, pieces are wrong");
    is( canSquare(1,15),        false, "Not enough sides");
    is( canSquare(4,6,5,5),     false, "Piece too long");

    is( canSquare((1..7),(1..7)),  true, "Lots of pieces that work");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
