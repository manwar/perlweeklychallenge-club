#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Math::Prime::Util qw(todigits vecprod);
use List::Util qw(uniqnum);
use List::Gen;
use experimental qw(signatures);

our ($tests, $examples, $help, $base, $len);
$base //= 10;
$len //= 3;

run_tests() if $tests || $examples;	# does not return

die <<EOS if $help;
usage: $0 [-examples] [-tests] [-help] [-base=BASE] [-len=LEN]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=BASE
    find colorful numbers in base BASE. Default: 10

-len=LEN
    find colorful number of length LEN (in base BASE). Default: 3

EOS


### Input and Output

gen_colorful($base, $len)->say;


### Implementation

# Build a generator for colorful numbers in base $base and length $len.
sub gen_colorful ($base, $len) {
    my ($lower, $upper) = ($base**($len - 1), $base**$len - 1);
    my $subsets = consecutive_subsets($len);

    <$lower..$upper>->filter(sub {is_colorful($_, $subsets, $base)});
}

# Check if a given number is colorful in base $base.  The "color" index
# subsets must be provided as the array ref $subsets.  The subset's last
# element's length defines the length of the colorful numbers.
sub is_colorful ($n, $subsets, $base) {
    my $len = $subsets->[-1]->@*;

    @$subsets == scalar uniqnum map vecprod((todigits $n, $base, $len)[@$_]),
        @$subsets;
}

# Generate an array of all consecutive subsets of indices 0 .. $len - 1.
sub consecutive_subsets ($len) {
    my @index = (0 .. $len - 1);
    my @res;
    for my $l (1 .. $len) {
        for my $i (0 .. $len - $l) {
            push @res, [$i .. $i + $l - 1];
        }
    }

    \@res;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_colorful(10, 3)->apply, bag {item 263; etc}, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
