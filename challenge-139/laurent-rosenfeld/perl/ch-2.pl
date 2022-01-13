use strict;
use warnings;
use feature "say";
use constant MAX => 800;

my $count = 0;

sub generate_primes {
    my @primes = (2, 3, 5, 7);
    my $current = 9;
    while (1) {
        my $prime = 1;   # True
        for my $i (@primes) {
            my $i_sq = $i * $i;
            last if $i_sq > $current;
            $prime = 0, last if $current % $i == 0;
        }
        push @primes, $current if $prime;;
        $current += 2;
        last if $current > MAX;
    }
    return @primes;
}

sub invert {
    my $n = shift;
    my $dividend = 1;
    my $result;
    my $max = 2 * $n;
    while (1) {
        $dividend *= 10;
        $result .= int($dividend / $n);
        return $result if length $result >= $n;
        my $remainder = $dividend % $n;
        $dividend = $remainder;
    }
    return $result;
}

my @primes = generate_primes;
for my $candidate (@primes[3..30]) {

    my $decimals = invert $candidate;
    my $len = length $decimals;
    ++$count and say "$candidate  $decimals " unless $decimals =~  /(\d{3,$len})\1/;
    last if $count >= 5;
}
