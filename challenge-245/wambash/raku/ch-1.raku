#!/usr/bin/env raku

sub sort-language (:@lang,:@popularity) {
    @popularity Z=> @lang
    andthen .sort
    andthen .map: *.value
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sort-language(:lang<perl c python>,:popularity(2,1,3)), <c perl python>;
    is sort-language(:lang<c++ haskell java>,:popularity(1,3,2)), <c++ java haskell>;
    is sort-language(:lang<raku ruby perl>,:popularity(2,3,1)), <perl raku ruby>;
    done-testing;
}

multi MAIN (:@lang,:@popularity) {
    put sort-language :@lang,:@popularity
}
