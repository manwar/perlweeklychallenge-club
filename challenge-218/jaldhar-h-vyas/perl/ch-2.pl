#!/usr/bin/perl
use 5.030;
use warnings;

sub sum {
    my ($arr) = @_;

    my $total = 0;

    for my $elem (@{$arr}) {
        $total += $elem;
    }

    return $total;
}

my @matrix;
for my $i (0 .. scalar @ARGV - 1) {
    my @row = split /,/, $ARGV[$i];
    push @matrix, \@row;
}
my $m = scalar @matrix;
my $n = scalar @{$matrix[0]};

for my $i (0 .. $m - 1) {
    if ($matrix[$i]->[0] eq '0') {
        for my $j (0 .. $n - 1) {
            $matrix[$i]->[$j] = ($matrix[$i]->[$j] eq '1' ? '0' : '1');
        }
    }
}

for my $i (0 .. $n - 1) {
    my $zeros = 0;
    my $ones = 0;
    for my $j (0 .. $m - 1) {
        $matrix[$j]->[$i] eq '0' ? $zeros++ : $ones++;
    }

    if ($zeros > $ones) {
        for my $j (0 .. $m - 1) {
            $matrix[$j]->[$i] = ($matrix[$j]->[$i] eq '1' ? '0' : '1');
        }
    }
}

say sum [ map { oct( '0b' . join q{}, @{$_} ) } @matrix ];
