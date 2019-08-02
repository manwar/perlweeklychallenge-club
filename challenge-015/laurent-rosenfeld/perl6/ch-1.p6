use v6;

my @p = grep { .is-prime }, 1..*;   #Lazy infinite list of primes
my @strong = map { @p[$_] },
    grep { @p[$_] > (@p[$_ - 1] + @p[$_ + 1]) / 2 }, 1..*;
my @weak = map { @p[$_] },
    grep { @p[$_] < (@p[$_ - 1] + @p[$_ + 1]) / 2 }, 1..*;
say "Strong primes: @strong[0..9]";
say "Weak primes: @weak[0..9]";
