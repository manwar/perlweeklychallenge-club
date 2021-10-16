#!/usr/bin/perl -s

use v5.16;
use PDL;
use Test2::V0 '!float';
use experimental 'signatures';

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [M N]

-examples
    run the examples from the challenge
 
M N
    count distinct elements in multiplication table for M and N

EOS


### Input and Output

say num_dist_terms(@ARGV[0, 1]);


### Implementation

# Calculate the multiplication table as the outer product of two
# sequences starting with 1, take the unique values thereof and count
# these.
# The task description together with its examples is ambiguous:
# "generate table and display count" I'd take as just to print the
# count.  OTOH, the examples provide the multiplication table, the
# distinct terms and the count in the OUTPUT section.  Lazily following
# the task description.

sub num_dist_terms ($m, $n) {
    outer(sequence(long, $m) + 1, sequence(long, $n) + 1)->uniq->dim(0);
}


### Examples and tests

sub run_tests {

    is num_dist_terms(3, 3), 6, 'example 1';
    is num_dist_terms(3, 5), 11, 'example 2';

    done_testing;
    exit;
}
