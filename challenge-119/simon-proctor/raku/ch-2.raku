#!/usr/bin/env raku

#|( Return the N'th value from the sequence )
multi sub MAIN( Int $N where * > 0 ) {
    seq-val($N).say;
}

multi sub MAIN( "test") is hidden-from-USAGE {
    use Test;
    is seq-val(5), 13;
    is seq-val(10), 32;
    is seq-val(60), 2223;
    done-testing;
}

sub seq-val( $N ) {
    (1..*).grep( { $_ !~~ /4|5|6|7|8|9|0/ } ).grep( { $_ !~~ /11/ })[$N-1];
}