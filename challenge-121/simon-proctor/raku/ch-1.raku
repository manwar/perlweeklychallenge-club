#!/usr/bin/env raku

subset EightBit of Int where 0 <= * <= 255;
subset ValidIdx of Int where 1 <= * <= 8;

multi sub MAIN('test') is hidden-from-USAGE {
    use Test;
    is bit-flipped( 12, 3 ), 8;
    is bit-flipped( 18, 4 ), 26;
    done-testing;
}

#| Given a number between 0 and 255 and a number between 1 and 8 flips the bit at index n
multi sub MAIN(
    EightBit $m, #= Integer between 0 and 255
    ValidIdx $n, #= Integer between 1 and 8
) {
    bit-flipped( $m, $n ).say;
}


sub bit-flipped( EightBit $m, ValidIdx $n ) {
    my @l = sprintf( "%08d", $m.base(2) ).comb();
    @l[8-$n] = 1-@l[8-$n];
    return @l.join("").parse-base(2);
}
