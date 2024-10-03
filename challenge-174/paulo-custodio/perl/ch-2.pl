#!/usr/bin/env perl

# Challenge 174
#
# Task 2: Permutation Ranking
# Submitted by: Mohammad S Anwar
#
# You are given a list of integers with no duplicates, e.g. [0, 1, 2].
#
# Write two functions, permutation2rank() which will take the list and determine
# its rank (starting at 0) in the set of possible permutations arranged in
# lexicographic order, and rank2permutation() which will take the list and a rank
# number and produce just that permutation.
#
# Please checkout this post for more informations and algorithm.
#
# Given the list [0, 1, 2] the ordered permutations are:
#
# 0: [0, 1, 2]
# 1: [0, 2, 1]
# 2: [1, 0, 2]
# 3: [1, 2, 0]
# 4: [2, 0, 1]
# 5: [2, 1, 0]
#
# and therefore:
#
# permutation2rank([1, 0, 2]) = 2
#
# rank2permutation([0, 1, 2], 1) = [0, 2, 1]

use Modern::Perl;
use Test::More;

sub fact {
    my($n) = @_;
    my $result = 1;
    $result *= $_ for 2..$n;
    return $result;
}

# https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
sub permutation2rank {
    my($p) = @_;
    my $n = scalar(@$p);
    my $fact = fact($n-1);              # (n-1)!
    my $rank = 0;
    my @digits = (0..$n-1);             # all unused digits
    for my $i (0..$n-2) {
        my($q) = map {$_->[0]}
                 grep {$_->[1] == $p->[$i]}
                 map {[$_, $digits[$_]]} 0..$#digits;
        $rank += $fact * $q;
        splice(@digits, $q, 1);         # remove digit p[i]
        $fact = int($fact / ($n-1-$i)); # weight of next digit
    }
    return $rank;
}

# https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
sub rank2permutation {
    my($p, $rank) = @_;
    my $n = scalar(@$p);
    my $fact = fact($n-1);              # (n-1)!
    my @digits = (0..$n-1);             # all unused digits
    my @p;
    for my $i (0..$n-1) {
        my $q = int($rank / $fact);     # by decomposing rank = q * fact + rest
        $rank %= $fact;
        push @p, $digits[$q];
        splice(@digits, $q, 1);         # remove digit at position q
        if ($i != $n-1) {
            $fact = int($fact / ($n-1-$i)); # weight of next digit
        }
    }
    return \@p;
}

is permutation2rank([1, 0, 2]), 2;
is_deeply rank2permutation([0, 1, 2], 1), [0, 2, 1];
done_testing;
