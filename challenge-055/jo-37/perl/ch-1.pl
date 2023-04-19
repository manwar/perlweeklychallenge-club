#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental qw(signatures);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [B]

-examples
    run the examples from the challenge
 
-tests
    run some tests

B
    binary number

EOS


### Input and Output

main: {
    local $" = ',';
    local $, = ',';
    say map "(@$_)", flip_max_bits(shift)->@*;
}


### Implementation

# Count the "ones" in all prefixes preceding L and the "ones" in all
# suffixes succeeding R.  Then loop over all (L, R) and count the
# "zeroes" in the according part.  The sum of the prefix ones, the
# middle zeroes and the suffix ones is the total number of "ones" after
# flipping the middle bits.  Recording all maxima.
sub flip_max_bits ($n) {
	my @lr;
    my $maxbits = '-Inf';
    my @lbits;
    my $tmp;
    push @lbits, ($tmp = substr $n, 0, $_) =~ tr/1/1/
        for (0 .. length($n) - 1);
    my @rbits;
    push @rbits, ($tmp = substr $n, $_ + 1) =~ tr/1/1/
        for (0 .. length($n) - 1);
    for my $l (0 .. length($n) - 1) {
        for my $r ($l .. length($n) - 1) {
            my $rbits = $rbits[$r];
            my $bits = $lbits[$l] + $rbits[$r] +
                ($tmp = substr $n, $l, $r - $l + 1) =~ tr/0/0/;
            if ($bits > $maxbits) {
                $maxbits = $bits;
                @lr = ([$l, $r]);
            } elsif ($bits == $maxbits) {
                push @lr, [$l, $r];
            }
        }
    }

    \@lr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is flip_max_bits('010'), [[0, 0], [0, 2], [2, 2]], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
