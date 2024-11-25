#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 297 Task 2 Semi-Ordered Permutation
#=============================================================================
# You are given permutation of $n integers, @ints.
# Write a script to find the minimum number of swaps needed to make the
# @ints a semi-ordered permutation.
# A permutation is a sequence of integers from 1 to n of length n containing
# each number exactly once. A permutation is called semi-ordered if the first
# number is 1 and the last number equals n.
# You are ONLY allowed to pick adjacent elements and swap them.
#
# Example 1 Input: @ints = (2, 1, 4, 3)
#           Output: 2
#   Swap 2 <=> 1 => (1, 2, 4, 3); Swap 4 <=> 3 => (1, 2, 3, 4)
# Example 2 Input: @ints = (2, 4, 1, 3)
#           Output: 3
#   Swap 4 <=> 1 => (2, 1, 4, 3) Swap 2 <=> 1 => (1, 2, 4, 3)
#   Swap 4 <=> 3 => (1, 2, 3, 4)
# Example 3 Input: @ints = (1, 3, 2, 4, 5)
#           Output: 0
#=============================================================================

use v5.40;
use Object::Pad;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

class Ints
{
    field $ints;

    method set($aref) { $ints = [ $aref->@* ]; return $self; }

    method semi() {
        # Find 1 and N in one pass. Could use List::MoreUtils::firstidx twice.
        my ($one, $N) = (-1, -1);
        for my ($i, $n) ( indexed $ints->@* )
        {
            if    ( $n == 1 )              { $one = $i }
            elsif ( $n == scalar(@$ints) ) { $N = $i }
            last if ( $one >=0 && $N >= 0 );
        }

        # 1 needs to be stepped down, N needs to be stepped up.
        # If they cross, that's one less swap required.
        my $swap = $one + ( $ints->$#* - $N ) - int($N < $one);

        return $swap;
    }
}

say Ints->new->set(\@ARGV)->semi();

sub runTest
{
    use Test2::V0;

    is( Ints->new->set([2,1,4,3  ])->semi(), 2, "Example 1");
    is( Ints->new->set([2,4,1,3  ])->semi(), 3, "Example 2");
    is( Ints->new->set([2,1,4,3  ])->semi(), 2, "Example 3");
    is( Ints->new->set([1,3,2,4,5])->semi(), 0, "Example 4");

    is( Ints->new->set([5,4,3,2,1])->semi(), 7, "Reverse 1..5 ");
    is( Ints->new->set([1])->semi(), 0, "Array of 1");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
