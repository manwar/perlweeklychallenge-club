#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# tested with: raku ch-1.raku 9 10 7 5 6 1

role leader-element {
    method get-leaders( @I = self».Int ) {
        @I.elems > 0 or (0).List.return;
        my $cur-leader = -1 + @I.min; # pseudo first leader
        @I.reverse.map(->\n
                       { $cur-leader <= n
                         ?? |($cur-leader = n).cache !! Empty } ).reverse.List;
    }
}

sub MAIN (*@I where { @I.all ~~ Int }) {
    my $I = @I does leader-element;
    $I.get-leaders.say;
}
