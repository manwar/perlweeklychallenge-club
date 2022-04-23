#!/usr/bin/env raku

sub is-abecedarian($word) {
    $word eq $word.comb.sort.join
}

multi MAIN (  ) {
    '../../../data/dictionary.txt'
    andthen .IO.lines
    andthen .grep: &is-abecedarian
    andthen .map: *.say
    ;
}

multi MAIN ( Bool :test($)! ) {
    use Test;
    is is-abecedarian('abcdef'), True;
    is is-abecedarian('abcdfe'), False;
    is is-abecedarian('moors'),  True;
    is is-abecedarian('ghost'),  True;
    is is-abecedarian('girls'),  False;
    done-testing;
}
