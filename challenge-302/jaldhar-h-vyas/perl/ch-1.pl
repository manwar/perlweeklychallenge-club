#!/usr/bin/perl
use v5.38;

sub max($first, $second) {
    return $first > $second ? $first : $second;
}

sub xx {
    my ($array, $amount) = @_;
    my @result = @{$array};

    for (1 .. $amount - 1) {
        push @result, @{$array};
    }

    return @result;
}

my ($x, $y, @str) = @ARGV;

my @dp;
for (0 .. $x) {
    push @dp,  [ xx([0], $y + 1) ];
}

for my $s (@str) {
    my $zeros = scalar grep { $_ eq '0' } split //, $s;
    my $ones = scalar grep { $_ eq '1' } split //, $s;

    for my $i (reverse 0 .. $x) {
        for my $j (reverse 0 .. $y) {
            if ($i >= $zeros && $j >= $ones) {
                $dp[$i][$j] = max($dp[$i][$j], 1 + $dp[$i - $zeros][$j - $ones]);
            }
        }
    }
}

say $dp[$x][$y];
