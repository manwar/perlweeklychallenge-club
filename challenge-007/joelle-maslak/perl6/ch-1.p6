#!/usr/bin/env perl6
use v6;

#
# Copyright © 2019 Joelle Maslak
# All Rights Reserved - See License
#

sub MAIN(UInt:D $max = 50) {
    for 0..$max -> $i {
        say $i if $i %% [+] $i.comb;
    }
}


