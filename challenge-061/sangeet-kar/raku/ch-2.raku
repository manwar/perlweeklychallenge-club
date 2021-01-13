#!/usr/bin/env raku

sub MAIN (Str $input="25525511135") {
    my $digs = rx/ 0 || <-[0]> \d ** 0..2 <?{ $/.Int ≤ 255 }> /;
    say $_[0].join('.') for $input ~~ m:ex/^ (<$digs>) ** 4 $/;
}
