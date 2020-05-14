#!/usr/bin/env raku

# Usage: raku ch-2.raku 0 1 2 5 2 21

sub MAIN (*@L where @L.all ~~ UInt) {
    my $y = @L.pop;
    my $x = @L.pop;

    say ([X~] @L xx $x).grep(/^<-[0]>/).grep(* < $y).join(", ");
}
