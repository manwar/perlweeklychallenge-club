#!/usr/bin/perl
# The Weekly Challenge 169
# Task 2 Achilles Numbers
use v5.24.0;
use warnings;

my $req = $ARGV[0] || 20;

my @prime = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37,
             41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97);

my @achilles = (-1);


my $found = 0;

for my $i (2..-1+72*($prime[-1]+2)) {
    my $powerful = 1;
    my $imperfect;
    my @prime_factors;
    for (@prime) {
        if ($i % $_ == 0) {
            push @prime_factors, $_;
            $powerful = 0 if ($i % ($_*$_) != 0);
        }
        last if !$powerful;
    }
    next if !$powerful;
    next if scalar @prime_factors == 0;
    next if scalar @prime_factors == 1;
    my @ppower;
    for my $pf (@prime_factors) {
        my $ind = 2;
        my $pp = $pf*$pf*$pf;
        while ($i % $pp == 0) {
            $ind++;
            $pp = $pp*$pf;
        } 
        push @ppower, $ind;
    }
    $imperfect = gcd(@ppower);

    if ($imperfect == 1) {
        push @achilles, $i;
        $found++;
    }
    last if $found == $req;
}

say join ", ", @achilles[1..$found];

die "$found terms are shown. You're asking too many, or I am too little!\n"
    if $req > $found;



sub gcd {
    my @num = @_;
    return gcd_pair($num[0], $num[1]) if scalar @num == 2;
    return gcd($num[0], gcd(@num[1..$#num]));
}



sub gcd_pair {
    my $n0 = $_[0];
    my $n1 = $_[1];
    ($n0, $n1) = ($n1, $n0) if $n0 > $n1;
    my $m = $n1 % $n0;
    return $n0 if $m == 0;
    return gcd_pair($m, $n0);
} 

