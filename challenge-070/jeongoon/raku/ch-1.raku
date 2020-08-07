#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

sub MAIN (
    Str:D $S = 'perlandraku',        #= string to change: default: 'peralandraku'
    Int:D $C where { $C >= 1 } = 3, #= how many times to change: >= 1; default: 3
    Int:D $O where { $O >= 1 && $C+$O < $S.chars } = 4, #= offset between character: default 4
) {

    my $N = $S.chars;
    my $K = $C > $O;
    $*ERR.say: "String: $S";
    $*ERR.say: "Params: C = {$C};   O = {$O};   N = {$N}";

    my $result;
    with $S {
        $result  = .substr( 0, 1 ) # 1
        ~ .substr( $C+2 .. $C+$O ) # 2
        ~ .substr( $K ?? $C-$O .. $C !! $C+1 .. $O ) # 3
        ~ .substr( 1 .. ( $C + $K*($O+1) ) ) # 4
        ~ .substr( ( $C+$O+1+$K) .. $N -1 );
    }
    $*ERR.say: "Output:";
    $result.say;
}
