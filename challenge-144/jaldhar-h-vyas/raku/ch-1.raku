#!/usr/bin/raku

sub MAIN() {
    my @semiprimes;

    for 2 .. 100 -> $n {
        my @factors = (2 .. $n / 2).grep({ $n %% $_ && $_.is-prime });

        if @factors.elems == 1 && @factors[0] * @factors[0] == $n {
            @semiprimes.push($n);
        } elsif @factors.combinations(2).map({ [*] $_; }).grep({ $_ == $n;}).elems {
            @semiprimes.push($n);
        }
    }

    @semiprimes.join(q{, }).say;
}
