#!/usr/bin/perl
use 5.038;
use warnings;

sub isFibonacci($n) {
    return isPerfectSquare(5 * $n * $n + 4) || isPerfectSquare(5 * $n * $n - 4);
}

sub isPerfectSquare($n) {
    my $s = int(sqrt($n));
    return $s * $s == $n;
}

sub sum(@arr) {
    my $total = 0;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my ($N) = @ARGV;
my @sums;
my $n = 0;
my $count = $N;

while ($count) {
    my $sum = sum((split //, $n));
    if (isFibonacci($sum)) {
        push @sums, $n;
        $count--;
    }
    $n++;
}

say join q{, }, @sums;
