#!/usr/bin/perl -s

use v5.16;
use warnings;
use PDL;
use experimental 'signatures';

our ($examples, $verbose);

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-verbose] [--] [A B]

-examples
    run some examples
 
-verbose
    Print intermediate piddles.

A B
    Two matrices given in any format accepted by the PDL constructor, e.g.
    '[1 2] [3 4]' or '1,2;3,4'

EOS


### Input and Output

say kronecker(pdl($ARGV[0]), pdl($ARGV[1]), $verbose);


### Implementation

# PDL::Matrix has 'kroneckerproduct' but its usage would not qualify as
# 'implementing Kronecker product'.
# Therefore taking a different approach:
# - replicate every element of A in the shape of B
# - replicate the whole matrix B in the shape of A.
# - the element-wise product of both replicated matrices results in a
#   "true" 4-dimensional Kronecker product.
# - "flattening" two dimensions gives the usual matrix result.
# The potential one-liner is split into four steps to be able to show
# the intermediate piddles.

sub kronecker ($a, $b, $verbose) {
    say "a: $a" if $verbose;
	my $ar = $a->dummy(0, $b->dim(0))->dummy(1, $b->dim(1));
    say "ar: $ar" if $verbose;

    say "b: $b" if $verbose;
    my $br = $b->dummy(2, $a->dim(0))->dummy(3, $a->dim(1));
    say "br: $br" if $verbose;

    my $k = $ar * $br;
    say "k: $k" if $verbose;

    $k->clump(0, 2)->clump(1, 2);
}


### Examples and tests

sub run_tests {

    say kronecker(1 + sequence(long, 2, 2), 5 + sequence(long, 2, 2), 1); 
    say kronecker(1 + sequence(long, 2, 3), 7 + sequence(long, 3, 5), 1);

    exit;
}
