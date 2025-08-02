#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 288 Task 2 Contiguous Block
#=============================================================================
# You are given a rectangular matrix where all the cells contain either x or o.
# Write a script to determine the size of the largest contiguous block.
# A contiguous block consists of elements containing the same symbol which
# share an edge (not just a corner) with other elements in the block, and
# where there is a path between any two of these elements that crosses only
# those shared edges.
# Example 1 Input: $matrix = [ ['x', 'x', 'x', 'x', 'o'],
#                              ['x', 'o', 'o', 'o', 'o'],
#                              ['x', 'o', 'o', 'o', 'o'],
#                              ['x', 'x', 'x', 'o', 'o'], ]
#           Output: 11
#   There is a block of 9 contiguous cells containing 'x'.
#   There is a block of 11 contiguous cells containing 'o'.
#
# Example 2 Input: $matrix = [ ['x', 'x', 'x', 'x', 'x'],
#                              ['x', 'o', 'o', 'o', 'o'],
#                              ['x', 'x', 'x', 'x', 'o'],
#                              ['x', 'o', 'o', 'o', 'o'], ]
#           Output: 11
#   There is a block of 11 contiguous cells containing 'x'.
#   There is a block of 9 contiguous cells containing 'o'.
# 
# Example 3 Input: $matrix = [ ['x', 'x', 'x', 'o', 'o'],
#                              ['o', 'o', 'o', 'x', 'x'],
#                              ['o', 'x', 'x', 'o', 'o'],
#                              ['o', 'o', 'o', 'x', 'x'], ]
#           Output: 7
#   There is a block of 7 contiguous cells containing 'o'.
#   There are two other 2-cell blocks of 'o'.
#   There are three 2-cell blocks of 'x' and one 3-cell.
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say contblock($_) for @ARGV;

sub contBlock($matrix)
{
    my $lastRow = $matrix->$#*;
    my $lastCol = $matrix->[0]->$#*;
    my $maxSize = 0;

    for my $row ( 0 .. $lastRow )
    {
        for my $col ( 0 .. $lastCol )
        {
            my $cell = $matrix->[$row][$col];
            next if $cell eq '#';

            my $count = 0;
            my @toDo = ( [$row, $col] );
            while ( @toDo )
            {
                my ($r, $c) = shift(@toDo)->@*;

                next unless $matrix->[$r][$c] eq $cell;
                $matrix->[$r][$c] = '#';
                $count++;

                push @toDo, [$r-1,$c  ] if $r > 0;
                push @toDo, [$r+1,$c  ] if $r < $lastRow;
                push @toDo, [$r  ,$c-1] if $c > 0;
                push @toDo, [$r  ,$c+1] if $c < $lastCol;
            }
            $maxSize = $count if $count > $maxSize;
        }
    }
    return $maxSize;
}

# Debugging aid
sub show($matrix)
{
    say join(' ', $_->@*) for $matrix->@*;
}


sub runTest
{
    use Test2::V0;
    my $matrix = [  ['x', 'x', 'x', 'x', 'o'],
                    ['x', 'o', 'o', 'o', 'o'],
                    ['x', 'o', 'o', 'o', 'o'],
                    ['x', 'x', 'x', 'o', 'o'], ];
    is( contBlock($matrix), 11, "Example 1");

       $matrix = [  ['x', 'x', 'x', 'x', 'x'],
                    ['x', 'o', 'o', 'o', 'o'],
                    ['x', 'x', 'x', 'x', 'o'],
                    ['x', 'o', 'o', 'o', 'o'], ];
    is( contBlock($matrix), 11, "Example 2");

       $matrix = [ ['x', 'x', 'x', 'o', 'o'],
                   ['o', 'o', 'o', 'x', 'x'],
                   ['o', 'x', 'x', 'o', 'o'],
                   ['o', 'o', 'o', 'x', 'x'], ];
    is( contBlock($matrix),  7, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
