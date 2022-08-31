#!/usr/bin/env raku

multi sub MAIN() is hidden-from-USAGE {
    use Test;
    is first-unique-index( 'Perl Weekly Challenge' ),0;
    is first-unique-index( 'Long Live Perl' ),1;
    is first-unique-index( 'a a'),1;
    done-testing;
}

#| Given a string return the first unique character index
multi sub MAIN( Str $string ) {
    say first-unique-index($string);
}

#| Given a list of string concatenates them with spaces then first unique character index
multi sub MAIN( *@phrase ) {
    say first-unique-index(@phrase.join(' '));
}


sub first-unique-index( Str \text ) {
    text.comb.Bag.pairs.map( { $_.value == 1 ?? text.index($_.key) !! Nil } ).min;
}
