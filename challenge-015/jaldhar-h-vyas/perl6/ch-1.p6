#!/usr/bin/perl6

multi sub MAIN() {
    my @primes = (1 .. ∞).grep({ .is-prime });

    my @strongPrimes = (1 .. ∞)
        .grep({ @primes[$_] > (@primes[$_ - 1] + @primes[$_ + 1]) / 2 })
        .map({ @primes[$_] });

    my @weakPrimes = (1 .. ∞)
        .grep({ @primes[$_] < (@primes[$_ - 1] + @primes[$_ + 1]) / 2 })
        .map({ @primes[$_] });

    say 'The 1st 10 strong Primes: ', join q{, }, @strongPrimes[^10];
    say 'The 1st 10 weak Primes: ',join q{, }, @weakPrimes[^10];
}