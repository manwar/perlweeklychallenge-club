#!/usr/bin/env raku

# Usage: raku ch-2.raku 0 1 2 5 2 21

sub MAIN (*@L where @L.all ~~ UInt) {
    my $Y = @L.pop;
    my $X = @L.pop;

    say ([X~] @L xx $X).grep(* !~~ /^0/).grep(* < $Y).join(", ");
}
