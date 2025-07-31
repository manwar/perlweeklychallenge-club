#!/usr/bin/env raku

multi buddy-strings ($source, $target where {$source eq $target}) {
   my @letters = $source.comb;
   @letters Zeq @letters.skip
   andthen .any
}

multi buddy-strings ($source, $target) {
    $source.comb Z, $target.comb
    andthen .grep: { .[0] !eq .[1] }, :v
    andthen { .elems == 2 and all .[0] Zeq .[1].reverse}
}

multi MAIN (Bool :test($)!) {
    use Test;
    is buddy-strings('fuck','fcuk'), True;
    is buddy-strings('love','love'), False;
    is buddy-strings('fodo','food'), True;
    is buddy-strings('fodo','fooo'), False;
    is buddy-strings('feed','feed'), True;
    done-testing;
}

multi MAIN ($source, $target) {
    say so buddy-strings $source, $target;
}
