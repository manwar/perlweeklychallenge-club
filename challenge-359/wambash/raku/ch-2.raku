#!/usr/bin/env raku

sub string-reduction ($word) {
    $word
    andthen .subst: /(.)<~~>?$0/, :g,:d
}

multi MAIN (Bool :test($)!) {
    use Test;
    is string-reduction('aabbccdd'), '';
    is string-reduction('abccba'), '';
    is string-reduction('abcdef'), 'abcdef';
    is string-reduction('aabbaeaccdd'), 'aea';
    is string-reduction('mississippi'), 'm';
    done-testing;
}

multi MAIN ($word) {
    say string-reduction $word;
}
