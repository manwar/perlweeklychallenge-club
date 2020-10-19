#!/usr/bin/perl6

sub factors(Int $n) {
    return  (1 .. $n div 2).grep({ $n %% $_ });
}

sub MAIN(Int $M, Int $N) {
    (factors($M) ∩ factors($N)).keys.sort.join(', ').say;
}