#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

# personal-blog: https://dev.to/jeongoon/weekly-challenge-083-task-2-raku-2cjm
# I wished this implementation faster but it wasn't
# I guess Raku doesn't like conditional flow control
# so... generating is simpler and faster than filtering ??

use v6.d;

multi MAIN ($n where * > 0) { say 0 }
multi MAIN (*@n where { @n.all ~~ Int and @n.all > 0 }) {
    my \TotalSum = @n.sum;
    my $half-len-floor = @n.elems div 2;
    @n.combinations( 1.. $half-len-floor ). # reduced combinations length
    race( :8degree:500batch ).
    map(
        -> $grp # current combination
        {
            my $a = $grp.sum; # sum of selected group
            my $b = (TotalSum - $grp.sum);
            given $a cmp $b {
                when Less {
                    ($b-$a) => $grp.elems
                }
                when More {
                    ($a-$b) => @n.elems - $grp.elems
                }
                default {
                    0 => ($grp.elems < $half-len-floor
                         # using shorter elems
                         ?? $grp.elems        !! @n.elems - $grp.elems)
                }
            }
        }
    ).
    race( :8degree:500batch ).
    min.
    value.
    say
}
