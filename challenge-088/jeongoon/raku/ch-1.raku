#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# tested with:
# raku jeongoon/ch-1.raku 5 2 1 4 3
# raku jeongoon/ch-1.raku 2 1 4 3
# raku jeongoon/ch-1.raku 100

multi sub MAIN (*@postive-integer where { @postive-integer.all ~~ Int
                                          and @postive-integer.all > 0
                                          and @postive-integer.elems > 0 } ) {
    my \t = [*] @postive-integer;
    @postive-integer.map(t/*).say;
}
