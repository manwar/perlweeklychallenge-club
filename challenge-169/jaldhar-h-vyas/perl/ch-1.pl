#!/usr/bin/perl
use 5.030;
use warnings;

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

my $n = 2;
my @brilliants;

until (scalar @brilliants == 20) {
    my @factors = factorize($n);
    if (scalar @factors == 2 && length $factors[0] == length $factors[1]) {
        push @brilliants, $n;
    }
    $n++;
}

say join q{, }, @brilliants;
