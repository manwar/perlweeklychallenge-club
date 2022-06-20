#!/usr/bin/perl
use 5.030;
use warnings;
use Math::Round qw/ nearest /;

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

sub isPerfect {
    my ($n) = @_;

    for my $i (map { nearest(0.001, log($n) / log($_ )) } 2 .. sqrt($n)) {
        if ($i == int $i) {
            return 1;
        }
    }

    return undef;
} 

sub isPowerful {
    my ($n) = @_;
    my %primeFactors;

    for my $factor (factorize($n)) {
        $primeFactors{$factor}++;
    }

    for my $factor (keys %primeFactors) {
        if ($n % ($factor ** 2) != 0) {
            return undef;
        }
    }

    return 1;
} 

my $n = 2;
my @achilles;

until (scalar @achilles == 20) {
    if  (isPowerful($n) && !isPerfect($n)) {
        push @achilles, $n;
    }
    $n++;
}

say join q{, }, @achilles;
