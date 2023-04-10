#!/usr/bin/env raku

use v6.d;

sub avg(List $l --> Rat) {
    sum($l) ÷ $l.elems;
}

sub same-average(List $l1, List $l2 --> Bool) {
    return avg($l1) == avg($l2);
}

sub check-split(Set $s1, Set $s2 --> Bool) {
    my $diff-set = $s1 (-) $s2;
    return same-average($s2.keys.List, $diff-set.keys.List);
}

sub create-n-split(List $l, Int $n --> Seq) {
    my @combs = combinations($l, $n);
    return map({ ($l.Set, $_.Set) }, @combs);
}

sub check-averages(List $l --> Bool) {
    my @splits = map({ |create-n-split($l, $_) }, 1 .. floor($l.elems ÷ 2));
    say @splits.elems;
    return so map({ check-split(|$_) }, @splits.race).any;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is check-averages((1, 2, 3, 4, 5, 6, 7, 8)), True, 'works for (1, 2, 3, 4, 5, 6, 7, 8)';
    is check-averages((1, 3)), False, 'works for (1, 3)';
}
