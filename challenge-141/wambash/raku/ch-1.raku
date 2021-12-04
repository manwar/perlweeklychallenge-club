#!/usr/bin/env raku

sub number-divisors ( :$divisors = 8, :$lowest = 10) {
    1 .. *
    andthen .grep: {
        $divisors == (1..$_).grep: $_ %% *
    }\
    andthen .head($lowest)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is number-divisors(:1lowest), 24;
    is number-divisors(:2divisors), (1..*).grep( *.is-prime).head(10);
    done-testing;
}

multi MAIN (|c) {
    put number-divisors(|c)
}
