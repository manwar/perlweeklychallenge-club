#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Permutation Ranking 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of integers with no duplicates, e.g. [0, 1, 2].
# Write two functions, permutation2rank() which will take the list and
# determine its rank (starting at 0) in the set of possible permutations
# arranged in lexicographic order, and rank2permutation() which will take
# the list and a rank number and produce just that permutation.
# Please checkout this post for more informations and algorithm.
# https://tryalgo.org/en/permutations/2016/09/05/permutation-rank
#
# Example: Given the list [0, 1, 2] the ordered permutations are:
#   0: [0, 1, 2]
#   1: [0, 2, 1]
#   2: [1, 0, 2]
#   3: [1, 2, 0]
#   4: [2, 0, 1]
#   5: [2, 1, 0]
# and therefore:
#   permutation2rank([1, 0, 2]) = 2
#   rank2permutation([0, 1, 2], 1) = [0, 2, 1]
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say permutation2rank(\@ARGV);

# How many CPU cycles have been wasted re-computing factorials?
my @Factorial = ( 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 3628800 );

sub permutation2rank($p)
{
    my $n = scalar(@$p);
    my $fact = 1;
    $fact *= $_ for 2 .. $n;

    my @indexOf;
    @indexOf[ $p->@* ] = 0 .. $p->$#*; 
    say "p      =($p->@*)" if $Verbose;
    say "indexOf=(@indexOf)" if $Verbose;

    my @digits = ( 0 .. $p->$#* );

    my $r = 0;
    for my $i ( 0 .. $n-1 )
    {
        my $q = $indexOf[ $p->[$i] ];
        $r += $fact * $q;
        say "p=($p->@*) i=$i q=$q fact=$fact r=$r" if $Verbose;

        $fact /= ($n- $i +1);
    }
    return $r;
}

sub rank2permutation($list, $rank)
{
}

sub runTest
{
    use Test2::V0;

    is( permutation2rank( [ 1, 0, 2 ] ),    2,         "Example p2r");
    is( rank2permutaiono( [ 0, 1, 2 ], 1 ), [0, 2, 1], "Example r2p");

    done_testing;
}
