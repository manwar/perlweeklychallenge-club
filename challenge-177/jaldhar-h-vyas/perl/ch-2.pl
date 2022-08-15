#!/usr/bin/perl
use 5.030;
use warnings;

sub isPalindromicPrimeCyclops {
    my ($n) = @_;
    return (isPrime($n)) && ($n eq reverse $n) &&
        (substr $n, (int ((length $n) / 2)), 1) eq '0';
}

sub isPrime {
    my ($n) = @_;

    if ($n < 2) {
        return undef;
    }

    if ($n == 2) {
        return 1;
    }

    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            return undef;
        }
    }

    return 1;
}

my @ppc;
my $n = 101;

while (scalar @ppc <= 20) {
    if (isPalindromicPrimeCyclops($n)) {
        push @ppc, $n;
    }

    $n += 2;
}

say join q{, }, @ppc;
