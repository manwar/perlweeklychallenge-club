# Write a script to generate first 10 strong and weak prime numbers.
#
# For example, the nth prime number is represented by p(n).
#
#   p(1) = 2
#   p(2) = 3
#   p(3) = 5
#   p(4) = 7
#   p(5) = 11
#
#   Strong Prime number p(n) when p(n) > [ p(n-1) + p(n+1) ] / 2
#   Weak   Prime number p(n) when p(n) < [ p(n-1) + p(n+1) ] / 2

my @p = (^Inf).grep: *.is-prime;
my @weak_prime_idx = (^Inf + 1).grep({ 2 * @p[$_] < @p[$_ - 1] + @p[$_ + 1] });
my @strong_prime_idx = (^Inf + 1).grep({ 2 * @p[$_] > @p[$_ - 1] + @p[$_ + 1] });

say "First 10 weak primes:";
@p[@weak_prime_idx[^10]].say;

say "First 10 strong primes:";
@p[@strong_prime_idx[^10]].say;
