#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# tested with:
# raku ch-1.raku -3 1 3 2 -2 4 6 7 -1 -4
# [-4 -3 -2 -1]
# [1 2 3 4]

unit sub MAIN (*@n where { @n ~~ Int, @n.elems > 0 } );
(@n.sort.map({[$_]})).
produce( ->  \a, \b {
                 b.first - a.tail == 1
                 ?? a.append(b.first).clone
                 !! b.clone
           } ).
classify( {.elems} ).
max.
value.
map( *.say );
