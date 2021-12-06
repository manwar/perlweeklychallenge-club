#!/usr/bin/perl
use 5.020;
use warnings;

sub hasEightDivisors {
    my ($n) = @_;
    my $count = 0;

    for my $i (1 .. $n) {
        if ($n % $i == 0) {
            $count++;
        }
    }

    return $count == 8;
}

my @eightDivisors;
my $n = 2;

while (scalar @eightDivisors < 10) {
    if (hasEightDivisors($n)) {
        push @eightDivisors, $n;
    }
    $n++;
}

say join q{, }, @eightDivisors;