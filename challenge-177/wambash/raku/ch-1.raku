#!/usr/bin/env raku
constant QG = <0317598642
  7092154863
  4206871359
  1750983426
  6123045978
  3674209581
  5869720134
  8945362017
  9438617205
  2581436790>
  .map: *.comb;

sub is-damn-iter ( Capture (:$check,:@n) ) {
    \(check => QG[$check; @n.head], n => @n.skip)
}

sub is-damn ($n) {
    \(:0check, n => $n.comb)
    andthen $_, &is-damn-iter ... *.<n>.elems == 0
    andthen .tail.<check> == 0
}

multi MAIN (Bool :test($)!) {
    use Test;
    is is-damn(5724),   True;
    is is-damn(5727),   False;
    is is-damn(112946), True;
    done-testing;
}

multi MAIN ($n) {
    say is-damn $n
}
