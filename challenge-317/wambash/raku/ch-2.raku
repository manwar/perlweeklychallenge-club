#!/usr/bin/env raku

sub friendly-strings ($str1,$str2) {
    $str1.comb Z=> $str2.comb
    andthen .grep: { .key !eqv .value }\
    andthen .cache
    andthen { .elems == 2 and  .head eqv .tail.antipair }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is friendly-strings('desc','dsec'),  True;
    is friendly-strings('fuck','fcuk'),  True;
    is friendly-strings('poo','eop'),  False;
    is friendly-strings('sprite','stripe'),  True;
    done-testing;
}

multi MAIN ($str1,$str2) {
    say friendly-strings  $str1,$str2
}
