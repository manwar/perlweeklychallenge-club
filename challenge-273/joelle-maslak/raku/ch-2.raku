#!/usr/bin/env raku
use v6.d;

#
# Copyright © 2024 Joelle Maslak
#

sub MAIN(Str:D $str) {
    my $match = $str ~~ m/^ <-[ b ]>* 'b' <!before 'a'>/;
    say "Output: " ~ ($match ?? "true" !! " false");
}