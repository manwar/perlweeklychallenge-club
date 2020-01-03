#!/usr/bin/env perl
#
# ch-1.pl - Attractive numbers, done badly!
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

# Here is how I'd normally tackle this problem:
# use Math::Prime::Util ':all';
# say for grep { is_prime( factor($_) ) } 1..50;

my @primes50   = primes_to(50);
my %primes50   = map  { $_ => 1 } @primes50;
my @attractive = grep { $primes50{ prime_div_mult($_) } } 1..50;

say for @attractive;

# Check our results against https://oeis.org/A063989
if ($ARGV[0] eq '--test') {
    use Test::More;
    my @oeis = (4, 6, 8, 9, 10, 12, 14, 15, 18, 20, 21, 22, 25, 26, 27, 28,
                30, 32, 33, 34, 35, 38, 39, 42, 44, 45, 46, 48, 49, 50);
    is_deeply \@attractive, \@oeis, "Matches published sequence";
    done_testing;
}

# Unmodified Wilson's theorem is terrible, unless you only need tiny primes!
# Please, I beg you, use Math::Prime::Util or similar in any real code. :-)
# N is prime iff (N - 1)! % N == 0
sub primes_to {
    use bigint;
    my $N = shift;
    my $fac = 1;
    my @r;
    for my $n (2..$N) {
        $fac *= $n - 1;

        push @r, $n unless ($fac + 1) % $n;
    }

    @r;
}

# Get prime divisors in multiplicity (e.g., 48 = 2, 2, 2, 2, 3)
sub prime_div_mult {
    my $n = shift;
    my @div;
    for my $div (@primes50) {
        last if $div > $n;
        while ($n % $div == 0) {
            $n /= $div;
            push @div, $div;
        }
    }

    @div;
}
