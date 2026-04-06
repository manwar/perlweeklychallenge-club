#!/usr/bin/env perl

# Perl Weekly Challenge 174 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-174/

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
