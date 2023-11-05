#!/usr/bin/perl
use 5.030;
use warnings;

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

sub factorize {
    my ($n) = @_;
    my @primeFactors;

    while ($n % 2 == 0) {
        push @primeFactors, 2;
        $n /=  2; 
    } 
     
    for (my $i = 3; $i <= sqrt $n; $i += 2)  { 
        while ($n % $i == 0) { 
            push @primeFactors, $i; 
            $n /= $i; 
        } 
    } 
     
    if ($n > 2) { 
        push @primeFactors, $n;
    }

    return @primeFactors;
}


say q{(},
(join q{, }, sort { scalar factorize($a) <=> scalar factorize($b) } @ARGV),
q{)};
