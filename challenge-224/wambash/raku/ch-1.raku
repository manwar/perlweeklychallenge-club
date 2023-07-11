#!/usr/bin/env raku

sub special-notes ($source, $target) {
    $target.comb.Bag ⊆ $source.comb.Bag
}

multi MAIN (Bool :test($)!) {
    use Test;
    is special-notes('xyz','abc'), False;
    is special-notes('scriptinglanguage', 'perl'), True;
    is special-notes('aabbcc','abc'), True;
    done-testing;
}

multi MAIN ($source, $target) {
    say special-notes $source, $target
}
