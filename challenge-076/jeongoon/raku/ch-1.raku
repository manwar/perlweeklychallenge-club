#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

subset PrimeNum of Int where { $^a > 1 }

multi minCombiPrimeSum ( PrimeNum:D $S ) {
    minCombiPrimeSum( $S, prime-numbers($S) );
}

multi minCombiPrimeSum ( PrimeNum:D $S, @pnums ) {
    my @rpn = @pnums.
                #sort. # already sorted in prime-numbers()
                reverse;

    say @rpn.raku if 0;
    # find only one possible combination
    for 1 .. @rpn.elems ->  $noc {
        for @rpn.combinations( $noc ) -> @pn {
            ($S == sum @pn) and @pn.return;
        }
    }

    # not found
    [].return;
}

sub prime-numbers ( PrimeNum:D $limit ) { # a poor prime number generator
    my PrimeNum @p = 3;
    my $candi = 3;
    [2].return   if $limit == 2;
    [2,3].return if $limit  < 5;

    NEW-NUMBER:
    while ( ($candi += 2) <= $limit ) {
        for @p -> $p { ($candi %% $p) and next NEW-NUMBER; }
        push @p, $candi;
    }
    [ 2, |@p ].return;
}

sub MAIN ( PrimeNum \S ) {
    my @a-combi =  minCombiPrimeSum( S );
    say "Input: " ~ S;
    say "Output: " ~ @a-combi.elems;
    say "a possible combination is {@a-combi.raku}";
}
