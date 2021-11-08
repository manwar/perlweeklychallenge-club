#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <n>

    <n>    integer greater than 0
-USAGE-
    exit(0);
}

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

sub factorize {
    my ($n, $primeFactors) = @_;
    if ($n < 2) {
        return;
    }

    my $p = nextPrime(1);
    while ($p <= $n) {

        if ($n % $p == 0) {
            push @{$primeFactors}, $p;
            factorize($n / $p, $primeFactors);
        }
        $p = nextPrime();
    }
}

sub isUgly {
    my ($n) = @_;
    my @primeFactors;
    factorize($n, \@primeFactors);
    return (scalar grep { $_ != 2 && $_ != 3 &&  $_ != 5 } @primeFactors) == 0;
}

my $n = shift // usage();

if ($n < 1) {
    usage;
}

my $number = 1;
my $uglies = 0;

while(1) {
    if (isUgly($number)) {
        $uglies++;
    }

    if ($uglies >= $n) {
        say $number;
        last;
    }

    $number++;
}
