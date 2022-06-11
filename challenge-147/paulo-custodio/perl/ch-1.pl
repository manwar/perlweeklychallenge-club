#!/usr/bin/env perl

# Challenge 147
#
# TASK #1 › Truncatable Prime
# Submitted by: Mohammad S Anwar
# Write a script to generate first 20 left-truncatable prime numbers in base 10.
#
# In number theory, a left-truncatable prime is a prime number which, in a given
# base, contains no 0, and if the leading left digit is successively removed,
# then all resulting numbers are primes.
#
# Example
# 9137 is one such left-truncatable prime since 9137, 137, 37 and 7 are all
# prime numbers.

use Modern::Perl;
use ntheory qw( is_prime next_prime );

my $it = left_truncatable_prime_it();
my @out;
for (1..20) {
    push @out, $it->();
}
say join(", ", @out);


sub left_truncatable_prime_it {
    my $prime;
    return sub {
        while (1) {
            $prime = defined($prime) ? next_prime($prime) : 2;
            return $prime if is_left_truncatable_prime($prime);
        }
    };
}

sub is_left_truncatable_prime {
    my($p) = @_;
    while (1) {
        return 0 if !is_prime($p);
        $p =~ s/.(.*)/$1/;
        return 1 if $p eq '';
    }
}
