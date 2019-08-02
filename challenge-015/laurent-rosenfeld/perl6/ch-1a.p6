use v6;

my @p = grep { .is-prime }, 1..*;   # Lazy infinite list of primes
say "Strong primes: ", (map { @p[$_] },
    grep { @p[$_] > (@p[$_ - 1] + @p[$_ + 1]) / 2 }, 1..*)[0..9];
say "Weak primes: ", (map { @p[$_] },
    grep { @p[$_] < (@p[$_ - 1] + @p[$_ + 1]) / 2 }, 1..*)[0..9];
