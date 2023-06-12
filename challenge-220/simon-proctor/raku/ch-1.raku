#!/usr/bin/env raku

#| Given a list of words return a list of letters that appear in all of them
multi sub MAIN( *@words ) {
    found-letters(@words).join(' ').say;
}

multi sub MAIN('TEST') is hidden-from-USAGE {
    use Test;
    is found-letters( 'Perl', 'Rust', 'Raku' ), ('r');
    is found-letters( 'love', 'live', 'leave' ), ('e','l','v');
    done-testing;
}

sub found-letters ( *@words ) {
    ( [∩] @words.map( *.fc.comb ) ).keys.sort;
}
