#!/bin/env perl6

my @pool;

say "A(0,$_) ", A(0, $_) for 0..9;
say "A(1,$_) ", A(1, $_) for 0..9;
say "A(2,$_) ", A(2, $_) for 0..9;
say "A(3,$_) ", A(3, $_) for 0..9;

sub A(UInt $m, UInt $n) returns UInt {
    return @pool[$m][$n] if @pool[$m][$n].defined;

    if $m == 0 {
        @pool[0][$n] = $n + 1;
    } elsif $n == 0 {
        @pool[$m][0] = A($m - 1, 1);
    } else {
        @pool[$m][$n] = A($m - 1, A($m, $n - 1));
    }

    return @pool[$m][$n];
}
