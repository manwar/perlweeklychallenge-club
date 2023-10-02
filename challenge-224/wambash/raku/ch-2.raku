#!/usr/bin/env raku

sub fibonacci-string ($x, $y, :$chars) {
    [\~] $x, $y, *+* ... * andthen .first: *.chars >= $chars
}

multi sub is-fibonacci-string($word, $x, $y) {
    $word eq fibonacci-string $x,$y, :chars( $word.chars )
}

sub additive-number ( $number ) {
    $number.match: / ^(\d+?) (\d+?) <?{is-fibonacci-string $number, $0, $1 }> \d+ $/
}

multi MAIN (Bool :test($)!) {
    use Test;
    is fibonacci-string(1,1,:20chars), '1123581321345589144233';
    ok  is-fibonacci-string(1123581321345589144233, 1,1);
    nok is-fibonacci-string(1123581321345589144234, 1,1);
    nok is-fibonacci-string(1123581321345589144233, 0,1);
    is ?additive-number(fibonacci-string 1 x 8 ,3 x 10, :100chars), True;
    is ?additive-number(112358), True;
    is  additive-number(112358).List, (1,1);
    is  additive-number(12345), Nil;
    is ?additive-number(199100199), True;
    is  additive-number(199100199).List, (1,99);
    done-testing;
}

multi MAIN ( $number ) {
    say ?additive-number $number
}
