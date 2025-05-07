#!/usr/bin/perl
use v5.38;

sub intersection($arr1, $arr2) {
    my %intersection;
    for my $i (@{$arr1}, @{$arr2}) {
        $intersection{$i}++;
    }

    return grep { $intersection{$_} > 1 } keys %intersection;
}

sub min(@arr) {
    return (sort { $a <=> $b } @arr)[0];
}

my @array_1 = split /\s+/, shift;
my @array_2 = split /\s+/, shift;

say min(intersection(\@array_1, \@array_2)) || -1;