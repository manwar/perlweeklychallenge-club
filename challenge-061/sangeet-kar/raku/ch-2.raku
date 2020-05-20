#!/usr/bin/env raku

sub MAIN (Str $input) {
    my $digs = rx/ 0 || <-[0]> \d ** 0..2 <?{ $/.Int ≤ 255 }> /;
    for $input ~~ m:ex/^ (<$digs>) ** 4 $/ -> $match {
            say ~@$match.list».join('.');
    }
}
