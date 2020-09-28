#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:
use v6.d;

constant big-num = 1000000007; # (10**9+7)
our &trunc = (*%(big-num)); # as spec requested. but no need in raku.
our &naive = {[+] (.base(2).indices(1).elems for ^$_[0]+1)};

# this is the rule what I found. I guess this is not bad.
#sub sum-a-section ($m) {
#    state @K = 1, 3;
#    # summation of the counts of bits between 2**(m) .. 2**(m+1)-1
#    @K[$m]:exists ?? @K[$m] !! ( @K[$m] = [+] (1+<$m), |@K[0..$m-1] );
#}

# 27th Sep 2020: there is a simpler way to calculate but
# my implementation doesn't help much
#sub sum-upto-power2 ($pow) { # bits sum between 0 .. 2^pow
#    [+] 1, |(sum-a-section($_) for 0..($pow-1));
#}
sub sum-upto-power2 ($pow) { # bits sum between 0 .. 2^pow
    1 + ( $pow * (1+<$pow) ) +> 1
}

sub count-set-bits ( UInt \N ) {
    N <= 2 and N.return;
    #N < 999 and naive(N).return; # no noticeable difference

    my $N = N;
    my ( $sum, $m );
    ++$m while $N +>= 1;

    $N = N - (1+<$m);
    $sum += sum-upto-power2($m);
    $N == 0 ?? $sum !! $sum + $N + count-set-bits($N);
}

our &MAIN=&say∘&trunc∘&count-set-bits;
