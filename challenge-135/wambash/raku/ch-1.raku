#!/usr/bin/env raku

multi middle-three-digits ($n where .abs.chars < 2) {
    fail 'too short'
}

multi middle-three-digits ($n where .abs.chars %% 2) {
    fail 'even number of digits'
}

multi middle-three-digits ($n) {
    $n.abs
    andthen .substr: .chars div 2 - 1, 3
}

multi MAIN (Int $n) {
    say middle-three-digits $n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is middle-three-digits("-123"), 123;
    is middle-three-digits('1234567'), 345;
    fails-like { middle-three-digits(-1) }, 'too short', 'fail: too short';
    fails-like { middle-three-digits(10) }, 'even number of digits','fail: even number of digits';
    done-testing;
}

