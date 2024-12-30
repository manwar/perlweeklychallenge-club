#!/usr/bin/env raku

sub step-by-step (+ints) {
    ints
    andthen [\+] $_
    andthen .min
    andthen 1 max (1 - $_)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is step-by-step(-3,2,-3,4,2),5;
    is step-by-step(1,2),1;
    is step-by-step(1,-2,-3),5;
    done-testing;
}

multi MAIN (+ints) {
    say step-by-step ints
}
