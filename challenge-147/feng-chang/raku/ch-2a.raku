#!/bin/env raku

# reference https://gfldex.wordpress.com/2022/01/15/manual-hypering/

sub needle(int \b) {
    sub is-pentagon(\n is raw) { (1 + sqrt(1 + 24 * n)) %% 6 }
    sub P(\n is raw) { n * (3 * n - 1) div 2 }

    loop (my int $s = 1; $s < b; ++$s) {
        my \bp = P(b);
        my \sp = P($s);
        if is-pentagon(bp + sp) && is-pentagon(bp - sp) {
            return |(b, $s);
        }
    }
}

sub infix:<notnilor>(\maybenil, \alternative) {
    maybenil =:= Nil ?? alternative !! maybenil
}

say (^∞).hyper(:batch(8), :degree(16)).map({ $_ with .&needle }).head;
