use strict;
use warnings;
use feature "say";
use constant MAX => 100;

sub primes {
    my $max = shift;
    my @primes = (2, 3, 5);
    PRIMES: for my $c (7..$max/2) {
        for my $i (2..$c/2) {
            next PRIMES unless $c % $i;
        }
        push @primes, $c;
    }
    return @primes;
}

my @p = primes MAX;
my @semi_primes;
# Generating pairs of primes and their product
for my $i (0..$#p) {
    for my $j (0..$i) {
        my $product = $p[$i] * $p[$j];
        push @semi_primes, $product if $product <= MAX;
    }
}
my @result;
my $j = -1;
# Removing duplicate products
for my $i (sort {$a <=> $b} @semi_primes) {
    push @result, $i if $i != $j;
    $j = $i;
}
say "@result";
