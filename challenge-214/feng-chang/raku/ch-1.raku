#!/bin/env raku

unit sub MAIN(*@N where @N.all ≥ 1);

@N = @N».Int.Array;

my %ndx;
for @N.sort({ $^a < $^b }).antipairs -> $p {
    %ndx{$p.key} = $p.value + 1 unless %ndx{$p.key}.defined;
}

put %ndx{@N}.map({ .trans('123' => 'GSB') }).join(', ');
