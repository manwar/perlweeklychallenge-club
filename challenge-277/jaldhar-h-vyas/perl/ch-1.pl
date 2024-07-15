#!/usr/bin/perl
use v5.38;

sub intersection($arr1, $arr2) {
    my %intersection;
    for my $i (@{$arr1}, @{$arr2}) {
        $intersection{$i}++;
    }

    return grep { $intersection{$_} > 1 } keys %intersection;
}

sub uniqueWords(@words) {
    my %freq;
    for my $word (@words) {
        $freq{$word}++;
    }

    return grep { $freq{$_} == 1 } keys %freq;
}

say scalar intersection(
    [uniqueWords(split /\s+/, $ARGV[0])],
    [uniqueWords(split /\s+/, $ARGV[1])]
);
