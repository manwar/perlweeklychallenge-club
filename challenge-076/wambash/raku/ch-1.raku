#!/usr/bin/env raku
#https://en.wikipedia.org/wiki/Goldbach%27s_conjecture
#Maybe, it does not work for all natural numbers.

subset OddPrime      of Int where { $_ !%% 2 &       .is-prime };
subset OddPrimeSucc  of Int where { $_ !%% 2 & ($_-2).is-prime };
subset Even of Int where *  %% 2;

proto prime-sum ($ where * ≥ 2 ) {*}
multi prime-sum (              2 --> 1 ) {}
multi prime-sum (OddPrime      $ --> 1 ) {}
multi prime-sum (Even          $ --> 2 ) {}
multi prime-sum (OddPrimeSucc  $ --> 2 ) {}
multi prime-sum (              $ --> 3 ) {}

sub MAIN (:$test) {
    use Test;
    is prime-sum(2),  1;
    is prime-sum(4),  2;
    is prime-sum(13), 1;
    is prime-sum(9),  2;
    is prime-sum(27), 3;
    dies-ok { prime-sum(1) };
    done-testing();
}
