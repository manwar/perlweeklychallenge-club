#!/usr/bin/env perl

# Perl Weekly Challenge 223 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-223/

use Modern::Perl;

my $n = shift || 0;
my $count = 0;
for (2..$n) {
    $count++ if is_prime($_);
}
say $count;

sub is_prime {
    my($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if ($n % 2)==0 || ($n % 3)==0;
    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }
    return 1;
}
