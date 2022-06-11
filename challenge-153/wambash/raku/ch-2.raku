#!/usr/bin/env raku

constant @Factorial = 1, slip [\*] 1..* ;

sub factorions ($n) {
    @Factorial[|$n.comb].sum == $n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is factorions(145),True;
    is factorions(123),False;
    done-testing;
}

multi MAIN ($n) {
    say +factorions $n
}
