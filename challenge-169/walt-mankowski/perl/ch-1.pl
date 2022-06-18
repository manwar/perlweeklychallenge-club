use v5.36;
use lib '.';
use primes qw(primes_to prime_factors);

# Task 1: Brilliant Numbers
#
# Write a script to generate first 20 Brilliant Numbers.
#
#     Brilliant numbers are numbers with two prime factors of the same length.
#
# The number should have exactly two prime factors, i.e. it’s the
# product of two primes of the same length.

$, = ' ';
my $MAX = 300;
my $primes = primes_to($MAX);

my @brilliant;
for (my $n = 4; @brilliant < 20 && $n <= $MAX; $n++) {
    my @factors = prime_factors($n, $primes);
    if (@factors == 2 && length($factors[0]) == length($factors[1])) {
        push @brilliant, $n;
    }
}

say @brilliant;
