#!/usr/bin/env raku

sub ethiopian-multiplication ( UInt $a, UInt $b ) {
    \( :$a, :$b ), { \( a => .<a> div 2, b => .<b> * 2 ) } ... *.<a> == 1
    andthen .grep: *.<a> !%% 2
    andthen .map:  *.<b>
    andthen .sum
}

subset PosInt of UInt where * !== 0;

multi MAIN (PosInt $a, PosInt $b) {
   say ethiopian-multiplication $a, $b
}

multi MAIN (Bool :$test!) {
    use Test;
    is ethiopian-multiplication( 14,12 ), 14*12, '14 * 12';
    is ethiopian-multiplication( |$_ ), .[0] * .[1] , .[0] ~ ' * ' ~ .[1] for [Z] (1 .. 10000).pick(10) xx 2;
    done-testing;
}
