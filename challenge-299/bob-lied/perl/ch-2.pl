#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 299 Task 2 Word Search
#=============================================================================
# You are given a grid of characters and a string.
# Write a script to determine whether the given string can be found in
# the given grid of characters. You may start anywhere and take any
# orthogonal path, but may not reuse a grid cell.
# Example 1 Input: @chars = (['A', 'B', 'D', 'E'],
#                            ['C', 'B', 'C', 'A'],
#                            ['B', 'A', 'A', 'D'],
#                            ['D', 'B', 'B', 'C'])
#                   $str = 'BDCA'
#           Output: true
# Example 2 Input: @chars = (['A', 'A', 'B', 'B'],
#                            ['C', 'C', 'B', 'A'],
#                            ['C', 'A', 'A', 'A'],
#                            ['B', 'B', 'B', 'B'])
#                     $str = 'ABAC'
#           Output: false
# Example 3 Input: @chars = (['B', 'A', 'B', 'A'],
#                            ['C', 'C', 'C', 'C'],
#                            ['A', 'B', 'A', 'B'],
#                            ['B', 'B', 'A', 'A'])
#                 $str = 'CCCAA'
#           Output: true
#=============================================================================
use v5.40;
use FindBin qw($Bin); use lib "$FindBin::Bin"; use Grid;
use List::MoreUtils qw/indexes/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my $word = shift;
my @grid = eval(shift);
say search(\@grid, $word) for @ARGV;

sub search($grid, $word)
{
    my $H = $grid->$#*;
    my $W = $grid->[0]->$#*;
    my $g = AOC::Grid->new(grid=>$grid, height=>$H, width=>$W);

    my @char = split("", $word);


    # Breadth-first search
    my @que;
    my $first = shift @char;
    for my $start ( findChar($grid, $first) )
    {
        push @que, [ $start, [ @char ] ];

        while ( my $x = shift @que )
        {
            my ( $loc, $rest) = $x->@*;
            return true if scalar(@$rest) == 0;

            my $next = shift @$rest;
            for my $nesw ( grep { $_->[0] eq $next } $g->aroundNESW(@$loc) )
            {
                push @que, [ $nesw->[1], [ $rest->@* ] ];
            }
        }
    }
    return false;
}

sub findChar($grid, $char)
{
    my @place;
    for my $r (0 .. $grid->$#*)
    {
        push @place, [$r, $_] for indexes { $_ eq $char } $grid->[$r]->@*;
    }
    return @place;
}

sub runTest
{
    use Test2::V0;

    my @Grid = ( [qw(A B D E)], [qw(C B C A)], [qw(B A A D)], [qw(D B B C)] );

    my @place = findChar(\@Grid, "A");
    is( \@place, [[0,0],[1,3],[2,1],[2,2]], "Find A");

    is( search(\@Grid, 'BDCA'),  true, "Example 1");

       @Grid = ( [qw(A A B B)], [qw(C C B A)], [qw(C A A A)], [qw(B B B B)] );
    is( search(\@Grid, 'BDCA'), false, "Example 2");

       @Grid = ( [qw(B A B A)], [qw(C C C C)], [qw(A B A B)], [qw(B B A A)] );
    is( search(\@Grid, 'CCAA'),  true, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
