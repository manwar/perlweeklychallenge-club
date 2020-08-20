#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# solution
role fnr {
    method sayLNR ( Str:D $str = self.Str ) {
        my @chars = $str.comb;
        my @candi = @chars.unique;

        for 1 .. @chars.elems -> $last-index {
            my $sub-chars = $str.substr( 0, $last-index );
            my $nr-pos =  -1;
            my $nr-char = '#';
            for @candi -> $c {
                given  $sub-chars.indices( $c ) {
                    .elems == 1 or next;
                    $nr-pos < .tail and ( $nr-char = $c, $nr-pos = .tail );
                }
            }
            print $nr-char;
        }
        say "";
    }
}

sub MAIN (
    Str:D $sample where *.chars > 0 = 'xyzzyx' #= string to find FNR
) {
    my $fnr-string = $sample does fnr;

    "Input: ".print;
    $fnr-string.say;
    "Output: ".print;
    $fnr-string.sayLNR;
}
