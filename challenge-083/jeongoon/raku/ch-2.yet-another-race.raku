#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# personal-blog: https://dev.to/jeongoon/weekly-challenge-083-task-2-raku-2cjm
# I hoped that this will be faster but it wasn't :-/

use v6.d;

multi MAIN ($n where * > 0) { say 0 }
multi MAIN (*@n where { @n.all ~~ Int and @n.all > 0 }) {
    my \B = @n.Bag;
    my \S = @n.sum;
    my $half-len-floor = @n.elems div 2;
    @n.combinations( 1.. $half-len-floor ).
    race( :8degree:1000batch ).
    map(
        -> $G
        {
            my $a = $G.sum; # sum of selected group
            my $b = (S - $G.sum);
            given $a - $b {
                if $_ < 0 {
                    -$_ => $G.elems
                } elsif $_ == 0 {
                    |( 0 => $G.elems, 0 => (B (-) $G.Bag).total )
                } else {
                    $_ => (B (-) $G.Bag).total
                }
            }
        }
    ).
    race( :8degree:1000batch ).
    min.
    say
}
