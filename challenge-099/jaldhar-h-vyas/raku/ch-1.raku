#!/usr/bin/raku

sub MAIN(
    Str $S, #= a string.
    Str $P  #= a pattern.
) {
    $S ~~ / ( <{ $P.subst('*', '.*', :g).subst('?', '.', :g) }> ) /;

    say ($0 && $S eq $0) ?? 1 !! 0;
}