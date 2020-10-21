#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# personal-blog: https://dev.to/jeongoon/weekly-challenge-083-task-2-raku-2cjm

use v6.d;

multi MAIN ($n where * > 0) { say 0 }
multi MAIN (*@n where { @n.all ~~ Int and @n.all > 0 }) {
    my $s = @n.sum;
    @n.combinations( 1..^ @n ).
    race( :8degree:500batch ).
    map(
        -> \n {
            with $s - 2 * n.sum { # same as ( $s- n.sum ) - n.sum
                next if $_ < 0;
                $_ => n.elems
            }
        } ).
    race( :8degree:5000batch ).
    min.
    value.
    say
}
