use strict;
use warnings;

# calc GCD Euclid's algorithm
# https://en.wikipedia.org/wiki/Greatest_common_divisor#Euclid's_algorithm

sub gcd {
    my ($x, $y) = @_;

    $y ? gcd($y, $x % $y) : $x;
}

# sum GCD of all possible unique pairs between 1 and $N

sub sum_gcd_unique_pairs {
    my $N = shift;
    my $sum = 0;

    for my $i (1 .. $N) {
        for my $j ($i+1 .. $N) {
            $sum += gcd($i, $j);
        }
    }
    return $sum;
}


1970;
