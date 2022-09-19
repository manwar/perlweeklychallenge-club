# The Weekly Challenge 174
# Task 2 Permutation Ranking
# O(n^2) solution, translation of Python code on
# https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
use v5.30.0;
use warnings;
use List::Util qw/first/;



sub factorial {
    my $ans = 1;
    for (1..$_[0]) {
       $ans *= $_; 
    }
    return $ans;
}



sub permutation2rank {
    my @list = $_[0]->@*;
    my $n = scalar @list;
    my $fact = factorial($n-1);
    my $r = 0;
    my @unused_list = sort {$a<=>$b} @list;
    for my $i (0..$n-2) {
        my $q = first { $unused_list[$_] == $list[$i] } 0..$#unused_list;
        $r += $q*$fact;
        splice @unused_list, $q, 1;
        $fact = int $fact / ($n-$i-1);
    }
    return $r;
}



sub rank2permutation {
    my @list = $_[0]->@*;
    my $r = $_[1];
    my $n = scalar @list;
    my $fact = factorial($n-1);
    my @unused_list = sort {$a<=>$b} @list;
    my @p = ();
    for my $i (0..$n-1) {
        my $q = int $r / $fact;
        $r %= $fact;
        push @p, $unused_list[$q];
        splice @unused_list, $q, 1;
        $fact = int $fact / ($n-1-$i) if $i != $n-1;
    }
    return [@p];
}



use Test::More tests=>3;
use Test::Deep;
ok permutation2rank([1,3,2,4,5]) == 6;
cmp_deeply rank2permutation([1,6,9],3), [6,9,1];
ok permutation2rank([9,7,5,3,1]) == 119;

