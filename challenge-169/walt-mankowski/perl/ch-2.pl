use v5.36;
use lib '.';
use primes qw(primes_to prime_factors);

# Task 2: Achilles Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Achilles Numbers. Please
# checkout wikipedia for more information.
#
#     An Achilles number is a number that is powerful but imperfect
#     (not a perfect power). Named after Achilles, a hero of the
#     Trojan war, who was also powerful but imperfect.
#
#     A positive integer n is a powerful number if, for every prime
#     factor p of n, p^2 is also a divisor.
#
#     A number is a perfect power if it has any integer roots (square
#     root, cube root, etc.).

$, = ' ';
my $MAX = 1800;
my $primes = primes_to($MAX);
my $perfect_power = powers_upto($MAX);

my @achilles;
for (my $n = 2; @achilles < 20 && $n <= $MAX; $n++) {
    my @factors = prime_factors($n, $primes);
    if (is_powerful(@factors) && !$perfect_power->{$n}) {
        push @achilles, $n;
    }
}

say @achilles;

# a number is powerful if there are at least 2 of each prime factor
sub is_powerful(@factors) {
    my %cnt;
    for my $i (@factors) {
        $cnt{$i}++;
    }
    for my $v (values %cnt) {
        return 0 if $v == 1;
    }
    return 1;
}

# there aren't that many perfect powers less than 1800, so since we know
# the answer we'll cheat a little and generate them all ahead of time
sub powers_upto($n) {
    my %powers;
    for my $i (2..sqrt($n)) {
        my $val = $i * $i;
        while ($val <= $n) {
            $powers{$val} = 1;
            $val *= $i;
        }
    }
    return \%powers;
}
