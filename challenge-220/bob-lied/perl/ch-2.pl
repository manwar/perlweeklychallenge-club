#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 220 Task 2 Squareful 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers, @ints.
# An array is squareful if the sum of every pair of adjacent elements is a
# perfect square. Write a script to find all the permutations of the given
# array that are squareful.
# Example 1: Input: @ints = (1, 17, 8)
#           Output: (1, 8, 17), (17, 8, 1)
#   (1, 8, 17) since 1 + 8 => 9, and also 8 + 17 => 25 are perfect squares.
#   (17, 8, 1) since 17 + 8 = 25 and 8 + 1 = 9 are squares.
# Example 2: Input: @ints = (2, 2, 2)
#           Output: (2, 2, 2)
#   Only one permutation with 2+2=4 and 2+2=4 (two different pairs).
#=============================================================================

use v5.36;

use Algorithm::Permute;
use List::Util qw(all);

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub isSquare($n)
{
    my $r = sqrt($n);
    return $r == int($r);
}

sub pairSum($list)
{
    return map { $list->[$_-1] + $list->[$_] } 1 .. ($list->$#*);
}

sub uniqify($arrOfArr)
{
    my %presence;
    my @unique;
    for my $list ( $arrOfArr->@* )
    {
        my $hash = join("|", $list->@*);
        push @unique, $list unless exists $presence{$hash};
        $presence{$hash} = 1;
    }
    return \@unique;
}


sub squareful(@ints)
{
    my @isSquareful;
    Algorithm::Permute::permute {
        push @isSquareful, [ @ints] if all { isSquare($_) } pairSum(\@ints)
    } @ints;
    return uniqify(\@isSquareful);
}

sub runTest
{
    use Test2::V0;

    is( isSquare(6), '', "isSquare no");
    is( isSquare(16), 1, "isSquare yes");

    is( [ pairSum([1,2,3,9]) ], [3,5,12], "pairSum");

    is(squareful(1, 17, 8), [ [1,8,17], [17,8,1] ], "Example 1");
    is(squareful(2,  2, 2), [ [2,2,2]            ], "Example 2");

    done_testing;
}
