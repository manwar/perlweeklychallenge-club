#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

sub isPrime($n) {
    if ($n < 2) {
        return false;
    }

    if ($n == 2) {
        return true;
    }

    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            return false;
        }
    }

    return true;
}

my @binary = @ARGV;
my @results;

for my $i (0 .. (scalar @binary - 1)) {
    push @results, isPrime(oct('0b' . join q{}, @binary[0 .. $i]));
}

say join q{ }, map { $_ ? 'true' : 'false' } @results;

