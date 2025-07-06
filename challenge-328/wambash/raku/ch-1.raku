#!/usr/bin/env raku


sub replace-iter ($str) {
    $str
    andthen .subst: / <-[a]> <( '?' )> <-[a]> /, 'a', :g
    andthen .subst: / a <( '?' )> b | b <( '?' )> a /, 'c', :g
    andthen .subst: / a <( '?' | '?' )> a /, 'b'
}

sub replace-all ($str) {
    $str, &replace-iter ... !*.contains('?')
    andthen .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is replace-iter('a?z'), 'abz';
    is-deeply replace-all('a?z'), 'abz';
    is-deeply replace-all('a???b'), 'abacb';
    is-deeply replace-all('???a'), 'baba';
    is-deeply replace-all('a??a'), 'abca';
    is replace-iter('pe?k'), 'peak';
    is replace-iter('gra?te'), 'grabte';
    is replace-iter('a?b'), 'acb';
    done-testing;
}

multi MAIN ($str) {
    say replace-all $str;
}
