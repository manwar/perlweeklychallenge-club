#!/usr/bin/env raku

my token integer { <[+-]>? \d+ };
my token decimal { <[+-]>? [ \d+ \.\d* | \.\d+ ] };
my token valid-number {^ [ <integer>|<decimal> ] [<[eE]> <integer>]? $};


sub valid-number-check ($str) {
    $str.contains: &valid-number
}

multi MAIN (Bool :test($)!) {
    use Test;
    is valid-number-check( '1'),      True;
    is valid-number-check('-1'),      True;
    is valid-number-check('a'),       False;
    is valid-number-check('.'),       False;
    is valid-number-check('1.2e4.2'), False;
    is valid-number-check('-1.'),     True;
    is valid-number-check('+1E-8'),   True;
    is valid-number-check('.43'),     True;
    is valid-number-check('1.2e4'),   True;
    done-testing;
}

multi MAIN ($str) {
    say valid-number-check $str
}
