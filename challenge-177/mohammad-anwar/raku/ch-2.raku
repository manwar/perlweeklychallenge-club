#!/usr/bin/env raku

=begin pod

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #2: Palindromic Prime Cyclops

    Write a script to generate first 20 Palindromic Prime Cyclops Numbers.

=end pod

use Test;

is [    101,   16061,   31013,   35053,   38083,   73037,   74047,
      91019,   94049, 1120211, 1150511, 1160611, 1180811, 1190911,
    1250521, 1280821, 1360631, 1390931, 1490941, 1520251,
], palindromic-prime-cyclops(20);

done-testing;

#
#
# METHODS

sub is-cyclops(Int $n --> Bool) {
    my @n = $n.comb;
    my $m = (@n.elems - 1) / 2;
    return False if @n.elems % 2 == 0
                 or @n[$m] != 0
                 or @n[0..$m-1].grep({ /<[0]>/ })
                 or @n[$m+1..@n-1].grep({ /<[0]>/ });
    return True;
}

sub is-palindrome(Int $n --> Bool) {
    return $n eq $n.flip;
}

sub palindromic-prime-cyclops(Int $n where $n > 0) {
    my @ppc = ();
    my $i   = 101;
    while @ppc.elems < $n {
        @ppc.push: $i
        if is-palindrome($i) and $i.is-prime and is-cyclops($i);
        $i += 2;
    }

    return @ppc;
}
