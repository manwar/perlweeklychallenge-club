#!/usr/bin/env raku

sub MAIN(UInt:D $size) {
    say +($_ eq .flip) given $size.base: 2;
}
