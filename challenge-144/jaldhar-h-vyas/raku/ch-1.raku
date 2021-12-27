#!/usr/bin/raku

sub MAIN(Int $n) {
    my @factors = (2 .. $n / 2).grep({ $n %% $_ && $_.is-prime });
    if @factors.elems == 1 {
        say @factors[0] * @factors[0] == $n ?? 1 !! 0;
    } else {
        say
            @factors.combinations(2).map({ [*] $_; }).grep({ $_ == $n;}).elems
            ?? 1 !! 0;
    }
}
