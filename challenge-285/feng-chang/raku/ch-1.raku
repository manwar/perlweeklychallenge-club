#!/bin/env raku

unit sub MAIN(Str:D $r);

my %routes = $r.comb.rotor(2).map({ .[0] => .[1] });
put %routes.values.grep({ !%routes{$_}.defined }).first;
