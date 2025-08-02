#!/usr/bin/env raku


sub dr-iter ($word, %letters){
    %letters ∖ $word.comb
    andthen .keys
    andthen .sort
    andthen $word X~ $_
}

sub dictionary-rank ($word) {
    my %letters := $word.comb.Bag ;

    q{},  { .map: { |dr-iter $_, %letters } } ... *
    andthen .skip: $word.chars
    andthen .head
    andthen .first: $word, :k
    andthen $_ + 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is dr-iter('c', bag <a a b> ), <ca cb>;
    is dictionary-rank('CAT'),3;
    is dictionary-rank('GOOGLE'), 88;
    is dictionary-rank('SECRET'), 255;
    is dictionary-rank('Mississippi'), 1137;
    is dictionary-rank('MISSISSIPPI'), 13737;
    done-testing;
}

multi MAIN ($word) {
    say dictionary-rank $word
}
