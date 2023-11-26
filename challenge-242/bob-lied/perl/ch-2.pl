#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 242 Task 2 Flip Matrix 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given n x n binary matrix.
# Write a script to flip the given matrix as below.
# Original  a) Reverse each row b) Invert each member
# 1 1 0        0 1 1               1 0 0
# 0 1 1        1 1 0               0 0 1
# 0 0 1        1 0 0               0 1 1
#
# Example 1 Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
#           Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])
# Example 2 Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
#           Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;
my $DoBenchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$DoBenchmark);
exit(!runTest()) if $DoTest;
exit(benchmark($DoBenchmark)) if $DoBenchmark;

sub flipMatrix($m)
{
    for my $row ( $m->@* )
    {
        for ( my ($front, $back) = (0, $row->$#*); $front <= $back ; $front++, $back-- )
        {
            $row->@[$front, $back] = map { ( $_ + 1 ) & 1 } $row->@[$back, $front];
        }
    }
    return $m;
}

sub flipMatrix_B($m)
{
    my @result;
    for my $row ( $m->@* )
    {
        push @result, [ map { $_ == 1 ? 0 : 1 } reverse $row->@* ];
    }
    return \@result;
}

sub flipMatrix_S($m)
{
    my @result;
    for my $row ( $m->@* )
    {
        (my $s = reverse qq($row->@*)) =~ tr/01/10/;
        push @result, [ split(" ", $s) ];
    }
    return \@result;
}

sub runTest
{
    use Test2::V0;

    is( flipMatrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]]),
        [[1, 0, 0], [0, 1, 0], [1, 1, 1]], "Example 1");

    is( flipMatrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]),
        [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], "Example 2");

    is( flipMatrix( [[]]),          [[]],          "0x0");
    is( flipMatrix( [[1]]),         [[0]],         "1x1");
    is( flipMatrix( [[1,0],[1,0]]), [[1,0],[1,0]], "2x2");

    is( flipMatrix_B([[1, 1, 0], [1, 0, 1], [0, 0, 0]]),
        [[1, 0, 0], [0, 1, 0], [1, 1, 1]], "B Example 1");

    is( flipMatrix_B([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]),
        [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], "B Example 2");

    is( flipMatrix_B( [[]]),          [[]],          "B 0x0");
    is( flipMatrix_B( [[1]]),         [[0]],         "B 1x1");
    is( flipMatrix_B( [[1,0],[1,0]]), [[1,0],[1,0]], "B 2x2");

    is( flipMatrix_S([[1, 1, 0], [1, 0, 1], [0, 0, 0]]),
        [[1, 0, 0], [0, 1, 0], [1, 1, 1]], "S Example 1");

    is( flipMatrix_S([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]),
        [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], "S Example 2");

    is( flipMatrix_S( [[]]),          [[]],          "S 0x0");
    is( flipMatrix_S( [[1]]),         [[0]],         "S 1x1");
    is( flipMatrix_S( [[1,0],[1,0]]), [[1,0],[1,0]], "S 2x2");
    done_testing;
}

sub benchmark($repeat)
{
    use Benchmark qw/:all/;

    cmpthese($repeat, {
        'my reverse' => sub { flipMatrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]) },
        'builtin reverse' => sub { flipMatrix_B([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]) },
        'string tr' => sub { flipMatrix_S([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]) },
    } );
    return 0;
}
