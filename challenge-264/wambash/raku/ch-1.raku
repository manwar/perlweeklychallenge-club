#!/usr/bin/env raku

sub greatest-english-letter ($str) {
    $str
    andthen .comb
    andthen .classify: { .uniprop }\
    andthen -> \x { x.<Lu>.grep: { .lc ∈ x.<Ll> } }\
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is greatest-english-letter('PeRlwEeKLy'),'L';
    is greatest-english-letter('ChaLlenge'),'L';
    is greatest-english-letter('The'), -Inf;
    done-testing;
}

multi MAIN ($str) {
    say greatest-english-letter $str
}
