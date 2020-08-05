#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:
use v6;

sub MAIN (
    Str:D $F where { $F.IO.r },         #= file path to open
    Int:D $A where { $A > 0  },         #= from
    Int:D $B where { $B >= $A },        #= to
         ) {

    for $F.IO.lines.kv -> $lnum, $line {
        say $line if $lnum == $A fff^ $lnum++ == $B;
        last if $lnum == $B;
    }
}
