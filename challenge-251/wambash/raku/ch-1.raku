#!/usr/bin/env raku

sub concatenation-value (+@ints) {
    my ($is-odd, $hl) = @ints.elems.polymod: 2 ;

    @ints
    andthen .head($hl) Z~ .reverse
    andthen .sum + ($is-odd && @ints[$hl])
}

multi MAIN (Bool :test($)!) {
    use Test;
    is concatenation-value( 1,  2, 10), 112;
    is concatenation-value( 6, 12, 25, 1), 1286;
    is concatenation-value(10,  7, 31, 5, 2, 2), 489;
    done-testing;
}

multi MAIN (*@ints) {
    say concatenation-value @ints
}
