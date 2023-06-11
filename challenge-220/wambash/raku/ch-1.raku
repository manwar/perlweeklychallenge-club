#!/usr/bin/env raku

sub common-characters (+@words) {
    @words
    andthen .map: *.lc.comb
    andthen [∩] $_
    andthen .keys.sort
}

multi MAIN (Bool :test($)!) {
    use Test;
    is common-characters(<Perl Rust Raku>), <r>;
    is common-characters(<love live leave>), <e l v>;
    done-testing;
}

multi MAIN (*@words) {
    put common-characters @words
}
