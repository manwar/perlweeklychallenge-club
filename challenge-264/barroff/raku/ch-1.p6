#!/usr/bin/env raku

use v6.d;

sub greatest-english-letter(Str:D $str --> Str:D) {
    my Set $letter-set = $str.comb.Set;
    my @candidates = grep(
        { $_.lc ∈ $letter-set and $_.uc ∈ $letter-set },
        $letter-set.keys
    ).map(&uc).sort;
    return @candidates[*-1] if @candidates;
    '';
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is greatest-english-letter("PeRlwEeKLy"), 'L', 'works for "PeRlwEeKLy"';
    is greatest-english-letter("ChaLlenge"), 'L', 'works for "ChaLlenge"';
    is greatest-english-letter("The"), '', 'works for "The"';
}

#| Take user provided words like CAT
multi sub MAIN(Str:D $str) {
    say greatest-english-letter($str);
}
