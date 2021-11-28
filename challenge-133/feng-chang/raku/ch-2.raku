#!/bin/env raku

sub facts(UInt:D \N where * > 1 --> Hash:D) {
    my Int $m = N;
	my Hash $F;

    for (^∞).grep: *.is-prime -> $p {
        while ($m %% $p) {
            ++$F{$p};
            $m div= $p;
        }

        last if $m < $p * $p;

        LAST { ++$F{$m} if $m > 1 }
    }

    $F
}

sub is-smith-number(UInt:D \N --> Bool:D) {
    return False if N.is-prime;

    my Hash $F = facts(N);
    N.comb.sum == $F.keys.map({ $_.comb.sum * $F{$_} }).sum
}

put (2..∞).grep({ is-smith-number($_) })[^10];
