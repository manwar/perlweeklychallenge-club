#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

subset Coin of Int where { $^a > 0 }

# solution
sub combiCoinSum ( Coin:D $S, @C ) {
    my @result;
    my @RC = @C.sort( { $^b <=> $^a } );  # (R)est of (C)oins
    my $fc = shift @RC;                  # (f)irst (c)oin

    $fc.defined or ().return;

    my $max-noc = $S div $fc;
    for $max-noc ... 0 -> $noc {
        my $change = $S - $fc * $noc;
        my @coins  = $fc xx $noc;
        if $change > 0 {
            with (combiCoinSum( $change, @RC )) {
                if .elems > 0 {
                    .map( -> @rest-coins
                          { @result.push( [ |@coins, |@rest-coins ] ) } );
                }
            }
        }
        elsif @coins.elems > 0 {
            @result.push( @coins );
        }
    }
    @result;
}

# testing
sub MAIN (
    Coin:D $S,                                   #= sum of coins
    **@C where { @C.elems > 0 and @C.all ~~ Coin } #= coin list
) {
    @C = @C>>.Int;
    my @combi = combiCoinSum( $S, @C );
    say "Input:\n\@C = {@C.raku}\n\$S = {$S}";
    say "Output: {@combi.elems}";
    say "possible ways are:";
    .say for @combi>>.Array;
}
