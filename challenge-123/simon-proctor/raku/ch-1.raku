#!/usr/bin/env raku

multi MAIN("Test") is hidden-from-USAGE {
    use Test;
    ok is-ugly(1);
    ok is-ugly(2);
    ok is-ugly(3);
    ok is-ugly(5);
    ok !is-ugly(7);
    ok !is-ugly(14);
    done-testing;
}

#| Given an Integer N return the Nth 'Ugly Number' (Indexed from 1), Given two number if prints the range
multi MAIN (
    Int \N where * > 0,
    Int \M where 0 < * >= N = N,
) {
    (1..*).grep( { is-ugly($_) } )[N-1..M-1].join(", ").say;
}

my %ugly;
multi is-ugly( Int() $ where * ~~ 1|2|3|5 ) { True }
multi is-ugly( Int() $n where $n %% 5 ) { %ugly{$n} //= is-ugly($n / 5) }
multi is-ugly( Int() $n where $n %% 3 ) { %ugly{$n} //= is-ugly($n / 3) }
multi is-ugly( Int() $n where $n %% 2 ) { %ugly{$n} //= is-ugly($n / 2) }
multi is-ugly( $ ) { False }
