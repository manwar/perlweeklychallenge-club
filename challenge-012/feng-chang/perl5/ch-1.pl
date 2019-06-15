#!/bin/env perl

use Modern::Perl;
use List::Util qw(min max);
use POSIX;

my @primes = (2, 3);

sub more_primes {
    my $to   = shift;
    my $from = $primes[-1] + 1;
    my $P;

    do {
        $P = $primes[-1];
        my @a = ($P + 1) .. min($to, $P * $P);

        for my $p (@primes) {
            for (my $i = ceil($from / $p) * $p - $from; $i <= $to; $i += $p) {
                $a[$i] = 0;
            }
        }

        for my $i (@a) {
            push(@primes, $i) if $i;
        }
    } while ($P * $P < $to);
}

sub is_prime {
    my $n = shift;

    my $e = int(sqrt($n));
    more_primes($e) if $e > $primes[-1];

    for my $p (@primes) {
        last if $p > $e;
        return 0 if $n % $p == 0;
    }

    return 1;
}

sub get_prime {
    my $idx = shift;
    return $primes[$idx] if $idx + 1 <= @primes;

    do {
        my $n = $primes[-1];
        more_primes($n * $n);
    } while ($idx + 1 > @primes);

    return $primes[$idx];
}

if (@ARGV) {
    my $n = $ARGV[0];
    say "$n is ", is_prime($n) ? '' : 'not ', 'prime';
    exit 0;
}

my $prod = 1;
my $i    = 0;
while (1) {
    $prod *= get_prime($i);
    print $primes[$i], ' ';
    last unless is_prime($prod + 1);

    ++$i;
}

say $prod + 1;
