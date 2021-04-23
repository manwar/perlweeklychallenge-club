#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::BigRat;
use List::Util 'reduce';
use experimental 'signatures';

use constant DEPTH => 10;
use constant PRECISION => 10;

our ($tests, $examples, $depth, $precision);

$depth ||= DEPTH;
$precision ||= PRECISION;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [-depth=d] [-precision=p] [K N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-depth=d
    build a continued fraction of depth 2d+1. Default: 10

-precision=p
    round result to p significant digits. Default: 10

K
    a number >= 1

N
    calculate N-th root of K, must be a positive integer

EOS


### Input and Output

my ($k, $n) = @ARGV;
die "$k is not a number >= 1" unless $k >= 1;
die "$n is not a positive integer" unless $n > 0 && $n == int $n;
my $r = nth_root($k, $n);
say $r->denominator == 1 ? $r->as_int : $r->as_float($precision);


### Implementation

# Find the largest integer r having r^n <= k
sub nth_int_root ($k, $n) {
    my $r = 0;
    0 while ++$r ** $n <= $k;

    $r - 1;
}

# Calculate the n-th root of k using Newton's method in a configurable
# number of steps.
# Though not explicitly requested, avoiding trivial expressions like
# $k ** (1/$n) or exp(log($k)/$n).  The task wouldn't make much sense
# otherwise.
sub nth_root ($k, $n) {
    my $x = nth_int_root($k, $n);
    my $y = $k - $x ** $n;
    # Stop if there is an integer solution.
    return Math::BigRat->new($x) if $y == 0;

    # Building a continued fraction of the form
    #             b1
    # a1 + ----------------
    #                b2
    #       a2 + ----------
    #                   b3
    #             a3 + ----
    #                   ...
    #
    #
    # The formula for the n-th root has been taken from
    # https://en.wikipedia.org/wiki/Nth_root#Using_Newton's_method
    #
    # Collect the "a" coefficients:
    my @a = ($x);
    my $x1 = $x ** ($n - 1);
    push @a, (2 * $_ - 1) * $n * $x1, 2 * $x for 1 .. $depth;

    # Collect the "b" coefficients:
    my @b = ($y);
    push @b, ($_ * $n - 1) * $y, ($_ * $n + 1) * $y for 1 .. $depth;

    # Calculate and return the continued fraction defined by the
    # coefficients in @a and @b.  'inf' as the reciprocal of zero acts
    # as the identity here and initiates BigRat arithmetics.  The value
    # of the last "b" coefficient has no effect whatsoever.
    reduce {$b / $a + pop @a} Math::BigRat->new('inf'), reverse @b;

}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is nth_root(248832, 5), 12, 'example 1';
        is nth_root(34, 5)->as_float(3), 2.02, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
        is nth_root(34, 5)->numify, float(2.024397458);
        is nth_root(62748518, 7)->numify, float(13.0000000295966);
	}

    done_testing;
    exit;
}
