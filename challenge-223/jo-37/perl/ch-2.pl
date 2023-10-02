#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

N...
    list of numbers

EOS


### Input and Output

say collect_max(@ARGV);


### Implementation

# This is more a guess than a solution.
# Some thoughts leading to this procedure:
# - The largest impact on the collected points comes from the product of
#   the  three largest numbers.  Thus removing elements until the three
#   largest number are left over.
# - Selecting a small number, though contributing little, may increase
#   the available products in the next step.  Thus selecting elements in
#   ascending order.
# - Selecting the smallest number providing the largest product is
#   required for consecutive minima and does not hurt otherwise.
# - When only three elements are left, the middle needs to be selected
#   to take advantage of the largest product.
#
# I'm curious about the comparison between this procedure's results with
# exact solutions.
#
# Update 2023/07/03:
# As expected, this procedure does not provide the correct results.  Fed
# some random data to the solutions from andreas-voegele, polettix and
# sgreen that seem to be correct and compared the results with mine.
# There is at lease one error in this approach: Whenever there are some
# consecutive minima in the list, not this minimum needs to be chosen
# but the larger neighbor. E.g. from (6 5 4 4) we need to choose 5
# instead of 4.

sub collect_max {
    my $l = long @_;
    $l->badflag(1);
    my $coll = 0;
    while (!$l->isempty) {
        say $l if $verbose;
        # Build a 2xN piddle holding the list elements together with
        # their corresponding (negative) triplet product.
        # Out-of-band values become BAD from "range" and are turned to
        # ones afterwards.
        my $vp = $l->glue(1, -$l->range($l->ndcoords - 1, 3, 't')
            ->setbadtoval(1)->xchg(0, 1)->prodover
        )->xchg(0, 1);
        # Get the index of the selected element as the smallest
        # value/product vector or the middle of a triplet.
        my $sel = $l->nelem == 3 ? 1 : qsortveci($vp)->((0));
        # Extract value and product.
        my ($v, $p) = $vp(,($sel))->list;
        # Collect the product.
        $coll -= $p;
        printf "select %d at %d and collect %d to total %d\n",
            $v, $sel, -$p, $coll if $verbose;
        # Remove the selected element.
        $l = $l->where($l->ndcoords != $sel);
    }
    $coll;
}


sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is collect_max(3, 1, 5, 8), 167, 'example 1';
        is collect_max(1, 5), 10, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is collect_max(1, 2, 1, 3, 1, 5, 1, 7), 197, 'looks sane';
        is collect_max(8, 6, 4, 2, 1, 3, 5, 7), 820, 'maximum configuration';
	}

    done_testing;
    exit;
}
