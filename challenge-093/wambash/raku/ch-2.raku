#!/usr/bin/env raku

grammar Tree {
    token TOP    { <node> }
    rule  node   { '(' ~ ')' [ <number>',' <branch>+ %% ',' ]  }
    token branch { <number> | <node> }
    token number { \d+ }
}

class SumPath-actions {
    method TOP    ($/) { make $<node>.made.sum }
    method node   ($/) { make slip $<number>.made X+ $<branch>».made }
    method branch ($/) { make slip $/.chunks.map: *.value.made }
    method number ($/) { make +$/ }
}

sub sum-path (Str $tree) {
    Tree.parse: $tree, actions => SumPath-actions.new
    andthen .made
}

multi MAIN (
    Str $tree       #= "(1,(2,3,4))"
) {
    say sum-path $tree
}

multi MAIN (Bool :$test) {
    use Test;
    is Tree.parse( '( 1, (2, 3, 4, ) )', actions => SumPath-actions.new, rule => 'node' ).made, (6,7);
    is sum-path( '(1,2,3,4)',         ), 12;
    is sum-path( '(1,(2,(3,(4,5))))', ), 15;
    is sum-path( '(1,(2,3,4))',       ), 13;
    is sum-path( '(1,(2,4),(3,5,6))', ), 26;
    done-testing;
}
