#!/usr/bin/env raku

sub acronyms (+array,:$word) {
    [and] zip $word.comb, array, :with(-> $l, $w {$w.starts-with: $l} )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is acronyms(<Perl Weekly Challenge>, :word<PWC>),True;
    is acronyms(<Bob Charlie Joe>, :word<BCJ>),True;
    is acronyms(<Morning Good>, :word<MM>),False;
    done-testing;
}

multi MAIN (+array,:$word) {
    say acronyms array, :$word
}
