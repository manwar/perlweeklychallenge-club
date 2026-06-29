#!/usr/bin/perl
use 5.40.1;
use warnings;

sub fromBase($number, $base) {
    my $scale = (length $number) - 1;
    my %digits;
    @digits{0..9, 'A'..'Z'} = 0 .. $base - 1;

    my $result;

    for my $digit (split //, $number) {
        my $base10 = $digits{uc $digit} // die "malformed base-$base number\n";
        $result += $base10 * $base ** $scale;
        $scale--;
    }

    return $result;
}

sub toBase($number, $base) {
    my @digits = (0 .. 9, 'A' .. 'Z')[0 .. $base - 1];
    my @result;

    if ($number == 0) {
        return 0;
    }

    while ($number > 0) {
        my $digit = int($number % $base);
        unshift @result, $digits[$digit];
        $number = int($number / $base);
    }

    return join '', @result;
}

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my ($base, $limit) = @ARGV;
my @armstrongs;

for my $n (0 .. $limit - 1) {
    my $N = toBase($n, $base);
    my $power = length $N;

    if (sum(map { fromBase($_, $base) ** $power } split //, $N) == $n) {
        push @armstrongs, $n;
    }
}

say join q{, }, @armstrongs;