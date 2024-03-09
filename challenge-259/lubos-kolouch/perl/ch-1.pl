use strict;
use warnings;
use feature 'say';

sub is_prime {
    my ($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if $n % 2 == 0 || $n % 3 == 0;
    my $i = 5;
    while ( $i * $i <= $n ) {
        return 0 if $n % $i == 0 || $n % ( $i + 2 ) == 0;
        $i += 6;
    }
    return 1;
}

sub prime_sum {
    my ($N) = @_;
    return 0 if $N < 2;
    return 1 if is_prime($N);
    return 2 if $N % 2 == 0;
    return 2 if is_prime( $N - 2 );
    return 3;
}

# Testing with example
my $N = 9;
say prime_sum($N);
