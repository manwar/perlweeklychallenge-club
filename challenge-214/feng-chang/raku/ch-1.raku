#!/bin/env raku

unit sub MAIN(*@N where @N.all ≥ 1);

@N = @N».Int.Array;

my %ndx;
for @N.sort({ $^b <=> $^a }).antipairs -> $p {
    %ndx{$p.key} = $p.value + 1 without %ndx{$p.key};
}

put %ndx{@N}.map({ .trans('123' => 'GSB') }).join(', ');
