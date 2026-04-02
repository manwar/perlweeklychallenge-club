#!/usr/bin/env perl

# Perl Weekly Challenge 170 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-170/

use Modern::Perl;

# https://en.wikipedia.org/wiki/Primality_test
sub is_prime {
    my($n) = @_;
    return 1 if $n == 2 || $n == 3;
    return 0 if $n <= 1 || $n % 2 == 0 || $n % 3 == 0;
    for (my $i = 5; $i * $i <= $n; $i += 6) {
        return 0 if $n % $i == 0 || $n % ($i + 2) == 0;
    }
    return 1;
}

sub next_prime {
    my($p) = @_;
    $p++;
    $p++ while !is_prime($p);
    return $p;
}

sub primorial_numbers {
    my($n) = @_;
    my @primorial = (1);
    my $p = 1;
    while (@primorial < $n) {
        $p = next_prime($p);
        push @primorial, $primorial[-1] * $p;
    }
    return @primorial;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
my $n=shift;
say "(", join(", ", primorial_numbers($n)), ")";
