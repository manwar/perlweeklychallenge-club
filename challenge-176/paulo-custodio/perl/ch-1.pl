#!/usr/bin/env perl

# Perl Weekly Challenge 176 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-176/

use Modern::Perl;

sub is_permuted {
    my($a, $b) = @_;
    return join('', sort split //, $a) eq join('', sort split //, $b);
}

sub is_permuted_multiple {
    my($n, $k) = @_;
    return is_permuted($n, $n*$k);
}

sub is_permuted_multiples {
    my($n) = @_;
    return is_permuted_multiple($n, 2) &&
           is_permuted_multiple($n, 3) &&
           is_permuted_multiple($n, 4) &&
           is_permuted_multiple($n, 5) &&
           is_permuted_multiple($n, 6);
}

sub smallest_permuted_multiples {
    my $n = 1;
    while (1) {
        return $n if is_permuted_multiples($n);
        $n++;
    }
}

say smallest_permuted_multiples();
