#!/bin/env raku

unit sub MAIN(Str:D $sent);

my method mix-up(Str:D $word :) {
    return $word if $word.chars ≤ 3;
    with $word.comb -> @w {
        return @w[0] ~ @w[1..^*-1].pick(*).join ~ @w[*-1];
    }
}

my method mix-parts(Str:D $word :) {
    $word.comb(/\w+|\W+/).map({ $++ %% 2 ?? .&mix-up !! $_ }).join
}

put $sent.words».&mix-parts.join(' ');
