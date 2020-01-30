#!/usr/bin/env perl6

#| Given a string encoded it using the square code
multi sub MAIN(
    *@clear-text #= Phrase to encode
) {
    roundrobin( @clear-text.map(*.lc.comb).flat.rotor( 8, :partial ) ).map(*.join("")).join(" ").say;
    
}


#| Given a square encoded string decode it
multi sub MAIN(
    Bool :d(:$decode)!, #= Turn on decode mode
    *@encoded #= Encoded phrase
) {
    roundrobin( @encoded.map(*.comb("")) ).flat.join("").say;
}
