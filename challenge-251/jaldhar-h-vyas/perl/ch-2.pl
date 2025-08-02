#!/usr/bin/perl
use 5.030;
use warnings;


sub intersection {
    my ($arr1, $arr2) = @_;
    my %intersection;
    for my $i (@{$arr1}, @{$arr2}) {
        $intersection{$i}++;
    }

    return grep { $intersection{$_} > 1 } keys %intersection;
}

sub max {
    my @arr = @_;
    my $highest = '-inf';
    for my $i (@arr) {
        if ($i > $highest) {
            $highest = $i;
        }
    }

    return $highest;
}

sub min {
    my @arr = @_;
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

my @matrix = map { [ map { 0 + $_} split /\s+/ ] } @ARGV;
my @mins;
my @maxs;

for my $i (0 .. scalar @matrix - 1) {
    push @mins, min(@{$matrix[$i]}) || -1;
}

for my $i (0 .. scalar @{$matrix[0]} - 1) {
    push @maxs, max(map { $matrix[$_]->[$i] } 0 .. scalar @matrix - 1) || -1;
}

say join q{ }, intersection(\@mins, \@maxs);
