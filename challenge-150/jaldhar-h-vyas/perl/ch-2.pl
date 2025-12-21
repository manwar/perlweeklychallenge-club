#!/usr/bin/perl
use 5.038;
use warnings;

sub isPrime($n) {

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

sub factorize($n) {
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

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return (keys %elems);
}

my @squareless = (1);

for my $n (2 .. 500) {
    my @primeFactors = factorize($n);

    if (@primeFactors == unique(@primeFactors)) {
        push @squareless, $n;
    }
}

say join q{, }, @squareless;
