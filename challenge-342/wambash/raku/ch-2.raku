#!/usr/bin/env raku

sub max-score (+$str) {
    $str
    andthen .match: /^ [(0)|1]+ [(1)|0]+ $/, :ex 
    andthen .map: { .[0] + .[1] }\                                                  
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is max-score('0011'), 4, 'split 0011 as 00|11 gives 2 zeros + 2 ones = 4';
    is max-score('0000'), 3, 'all zeros: best split 000|0 gives 3 zeros + 0 ones = 3';
    is max-score('1111'), 3, 'all ones: best split 1|111 gives 0 zeros + 3 ones = 3';
    is max-score('0101'), 3, 'alternating bits: split 0|101 gives 1 zero + 2 ones = 3';
    is max-score('011101'), 5, 'mixed pattern: split 0|11101 gives 1 zero + 4 ones = 5';
    done-testing;
}

multi MAIN (+$str) {
    say max-score $str;
}
