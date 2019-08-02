#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use integer;

use constant COUNT => 5;

my @primes = (2);

sub sum_subsets {
    my ($p, @numbers) = @_;
    my $binary        = 1;
    my $sum           = 1; # Always a divisor.
    my %seen;

    while (1) {
        my @zero_ones = split //, sprintf '%b', $binary++;
        unshift @zero_ones, (0) x (@numbers - @zero_ones);
        last unless grep ! $_, @zero_ones;

        my $divisor = 1;
        $divisor *= $numbers[$_] for grep $zero_ones[$_], 0 .. $#zero_ones;
        next if exists $seen{$divisor};

        undef $seen{$divisor};
        $sum += $divisor;
        last if $sum > $p;
    }
    return $sum
}


sub factorize {
    my ($n)         = @_;
    my $prime_index = 0;
    my ($f, @factors);

    while ($n > 1) {
        $f = $primes[$prime_index] // ($f + 1);

        if ($n % $f) {
            $prime_index++;

        } else {
            push @factors, $f;
            $n /= $f;
        }
    }
    return @factors
}

my $perfect_tally = 0;
my $p = 2;
while ($perfect_tally < COUNT) {
    my @factors = factorize($p);
    if (1 == @factors and $p > $primes[-1]) {
        push @primes, $p;
    }
    my $product = sum_subsets($p, @factors);
    if ($product == $p) {
        $perfect_tally++;
        say $p;
    }
} continue {
    $p++;
}
