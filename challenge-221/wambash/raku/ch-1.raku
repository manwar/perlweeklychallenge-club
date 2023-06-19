#!/usr/bin/env raku

sub good-strings (+@words, :$chars) {
    @words
    andthen .map: *.comb.Bag
    andthen .grep: { $_ ⊆ $chars.comb.Bag }\
    andthen .map: *.total
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is good-strings(<cat bt hat tree>, :chars('atach')), 6;
    is good-strings(<hello world challenge>, :chars('welldonehopper')), 10;
    done-testing;
}

multi MAIN (*@words, :$chars) {
    put good-strings @words, :$chars
}
