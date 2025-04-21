#!/usr/bin/env raku

multi reverse-equals (@source, @target where @source eqv @target) { True }
multi reverse-equals (@source,@target) {
    @source Z[!==] @target
    andthen .grep: *.value, :k
    andthen { @^ind.head .. @^ind.tail }\
    andthen @source[$_].Seq eqv @target[$_].reverse
}

multi MAIN (Bool :test($)!) {
    use Test;
    is reverse-equals((3,2,1,4),(1,2,3,4)),True;
    is reverse-equals((1,3,4),(4,1,3)),False;
    is reverse-equals((2,),(2,)), True;
    done-testing;
}

multi MAIN ($source,$target) {
    say reverse-equals $source.comb(/\d+/),$target.comb(/\d+/)
}
