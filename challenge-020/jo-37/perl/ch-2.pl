#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen;
use Math::Prime::Util 'divisor_sum';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    find the first N amicable pairs

EOS


### Input and Output

gen_amicable_pairs()->map(sub{"(@$_)"})->say(shift);


### Implementation

# Build a generator for amicable pairs.
sub gen_amicable_pairs {
    my %pairs;
    <2..>->filter(sub {
            # Skip seen pairs.
            return if exists $pairs{$_};
            my $s = divisor_sum($_) - $_;
            # Skip perfect numbers.
            return if $s == $_;
            my $t = divisor_sum($s) - $s;
            # Skip non-pairs.
            return if $_ != $t;
            # Remember the second.
            $pairs{$s} = undef;
            # Pair the second with the first and return "true".
            $pairs{$_} = $s;
        })
    # Actually build the pairs.
    ->map(sub{[$_, $pairs{$_}]});
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_amicable_pairs()->take(10),
        [[220, 284], [1184, 1210], [2620, 2924], [5020, 5564],
            [6232, 6368], [10744, 10856], [12285, 14595],
            [17296, 18416], [63020, 76084], [66928, 66992]],
        'first ten pairs from Wiki';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
