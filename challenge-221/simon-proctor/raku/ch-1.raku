#!/usr/bin/env raku

#|( Given a string of the avaliable letters and a series of
words print the total length of all the words that can be
made from the letters only
)
multi sub MAIN( $valid-letters, #= All the available letters as a string
                *@words #= The words list
              ) {
    say [+] valid-strings( $valid-letters, |@words ).map( *.comb.elems );
}

multi sub MAIN('TEST') is hidden-from-USAGE {
    use Test;
    is valid-string('atach','cat'), True;
    is valid-string('atach','bt'), False;

    is valid-strings('atach','cat','bt','hat','tree'), ('cat', 'hat');
    is valid-strings('welldonehopper','hello','world','challenge'),
                    ('hello', 'world');
    

    done-testing;
}

sub valid-string( $valid, $string ) {
    my $bh = $valid.comb.BagHash;
    for ( $string.comb ) -> $v {
        return False unless $bh{$v};
        $bh{$v}--;
    }
    return True;
}

sub valid-strings( $chars, *@words ) {
    return @words.grep( -> $s { valid-string( $chars, $s ) } ); 
}
