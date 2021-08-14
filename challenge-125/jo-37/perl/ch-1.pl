#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(fordivisors sqrtint lastfor is_power);
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [-verbose] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    Find all Pythagorean triples containing N

EOS


### Input and Output

map {say "(@$_)"} find_pythagorean_triples(pop @ARGV) or say -1;


### Implementation

# According to Euclid's formula, all Pythagorean triples x² + y² = z²
# can be parametrized using u > v > 0:
# x = u² - v²
# y = 2uv
# z = u² + v².
#
# There is a solution for every n > 2:
# (k + 1)² - k² = 2k + 1, therefore every odd number > 2 appears as x
# and on the other hand every even number > 2 appears as y.
#
# References:
# https://en.wikipedia.org/wiki/Pythagorean_triple


# Loop over three subs that find all valid parameters u and v
# reproducing the given number as x, y or z and collect their results.
sub find_pythagorean_triples ($n) {
    my @pt;
    $_->(\@pt, $n) for
        # Triples with x = n
        sub ($pt, $x) {
            # There is no v < u if u² - (u - 1)² > x or u² ≤ x.
            # Resolved to u:
            for my $u (sqrtint($x) + 1 .. ($x + 1) / 2) {
                # The three-argument version of "is_power" checks if the
                # given number is a perfect power and returns the
                # integer root at the same time.  Incredibly handy.
                next unless is_power($u**2 - $x, 2, \my $v);
                push @$pt, [$x, 2 * $u * $v, $u**2 + $v**2];
            }
        },
        # Triples with y = n
        sub ($pt, $y) {
            return if $y % 2;
            fordivisors {
                my ($u, $v) = ($y / (2 * $_), $_);
                lastfor, return if $v >= $u;
                push @$pt, [$u**2 - $v**2, $y, $u**2 + $v**2];
            } $y / 2;
        },
        # Triples with z = n
        sub ($pt, $z) {
            # There is no u > v if (v + 1)² + v² > z.
            # Resolved to v:
            for my $v (1 .. (sqrtint(2 * $z - 1) - 1) / 2) {
                next unless is_power($z - $v**2, 2, \my $u);
                push @$pt, [$u**2 - $v**2, 2 * $u * $v, $z];
            }
        };

    @pt;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        like [find_pythagorean_triples(5)],
            bag {item [5, 12, 13]; item [3, 4, 5]; end}, 'example 1';

        like [find_pythagorean_triples(13)],
            bag {item [13, 84, 85]; item [5, 12, 13]}, 'example 2';

        is [find_pythagorean_triples(1)], [], 'example 3'
    }

    SKIP: {
        skip "tests" unless $tests;

        like [find_pythagorean_triples(20)],
            bag {
                item [12, 16, 20];
                item [99, 20, 101];
                item [21, 20, 29];
                item [20, 48, 52];
                end}, 'n in all positions';
        is [find_pythagorean_triples(2)], [],
            'the only other number without a solution';

        like [find_pythagorean_triples(7)],
            bag {item [7, 24, 25]; etc}, 'as x';
        like [find_pythagorean_triples(30)],
            bag {item [224, 30, 226]; item [16, 30, 34]; etc}, 'as y';
        like [find_pythagorean_triples(13)],
            bag {item [5, 12, 13]; etc}, 'as z'; 
        like [find_pythagorean_triples(15485863)],
            bag {item [15485863, 119905976427384, 119905976427385]; end},
            '1000000-th prime';
	}

    done_testing;
    exit;
}
