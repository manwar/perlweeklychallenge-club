#!/usr/bin/perl
use v5.38;

sub intersection($arr1, $arr2) {
    my %intersection;
    for my $i (@{$arr1}, @{$arr2}) {
        $intersection{$i}++;
    }

    return grep { $intersection{$_} > 1 } keys %intersection;
}

my @str1 = split /\s+/, shift;
my @str2 = split /\s+/, shift;

say scalar intersection(\@str1, \@str2);
