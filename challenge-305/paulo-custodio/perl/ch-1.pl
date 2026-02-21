#!/usr/bin/env perl

use Modern::Perl;

@ARGV or die "usage: $0 binary-digits...\n";
say "(", join(", ", map {$_ ? 'true' : 'false'} bin_prefix(@ARGV)), ")";

sub is_prime {
    my ($n) = @_;

    return 0 if $n < 2;          # 0 and 1 are not prime
    return 1 if $n == 2;         # 2 is the only even prime
    return 0 if $n % 2 == 0;    # Skip all other even numbers

    # Check odd divisors up to the square root of n
    for (my $i = 3; $i <= sqrt($n); $i += 2) {
        return 0 if $n % $i == 0;
    }

    return 1; # If no divisors were found, it's prime
}

sub bin_prefix {
    my(@digits) = @_;
    my $n = 0;
    my @out;
    for (@digits) {
        $n = $n * 2 + $_;
        push @out, is_prime($n);
    }
    return @out;
}
