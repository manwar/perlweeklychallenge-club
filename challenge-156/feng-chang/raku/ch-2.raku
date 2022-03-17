#!/bin/env raku

unit sub MAIN(UInt:D \n);

put +is-weird(n);

sub proper-divisors(UInt:D \n) { (1..^n).grep({ n %% $_ }) }

sub is-weird(UInt:D \n) {
    my @d = proper-divisors(n);
    my \和 = @d.sum;

    和 > n and @d.combinations».sum.grep(* == 和 - n).elems == 0
}
