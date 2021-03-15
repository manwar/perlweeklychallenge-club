#!/bin/env raku

sub USAGE {
    put "$*PROGRAM 0\n" ~
        "$*PROGRAM 1\n" ~
        "$*PROGRAM opt bat saw tab pot top was\n" ~
        "$*PROGRAM x";
}

sub group-anagrams(@S) {
    for @S».comb».sort».join.unique -> $foo {
        put @S.grep(*.comb.sort.join eq $foo).join(', ');
    }
}

my @T = <opt bat saw tab pot top was>, [<x>];
multi MAIN()          { USAGE }
multi MAIN(UInt:D \n) { group-anagrams(@T[n]) }
multi MAIN(*@S)       { group-anagrams(@S) }
