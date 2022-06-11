#!/usr/bin/perl
use 5.030;
use warnings;

sub isPrime {
    my ($n) = @_;

    if ($n < 2) {
        return undef;
    }

    if ($n == 2) {
        return 1;
    }

    for my $i (2 .. sqrt($n)) {
        if ($n % $i == 0) {
            return undef;
        }
    }

    return 1;
}

sub nextPrime {
    state $i = 1;
    if (scalar @_) {
        $i = shift;
    }

    while ($i++) {
        if (isPrime($i)) {
            return $i;
        }
    }
}

my @fortunates;

my $i = 0;
while (scalar @fortunates < 8) {
    my $pn = nextPrime(1);

    for my $j (1 .. $i++) {
        $pn *= nextPrime();
    }

    my $m = $pn + 1;

    while($m++) {
        if (isPrime($m) && !grep { $_ == $m - $pn } @fortunates) {
            push @fortunates, $m - $pn;
            last;
        }
    }
}

say join q{, }, sort {$a <=> $b} @fortunates;
