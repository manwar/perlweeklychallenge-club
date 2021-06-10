#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(vecsum stirling);

our $tests;

run_tests() if $tests;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-tests] [num]

-tests
    run some tests

num
    print first <num> Bell numbers.

EOS


### Input and Output

say "$_  ", B($_) for 0 .. $ARGV[0] - 1;


### Implementation

# Facing this task after having played with Math::Prime::Util for some
# weeks, the module shouts: "Use me!"  And in fact: The Bell numbers
# appear as an example.  This looks like a one week leave.
# Taking a verbatim copy from the module's POD.

sub B { my $n = shift; vecsum(map { stirling($n,$_,2) } 0..$n) }

### Examples and tests

sub run_tests {
    my $i = 0;
    for (1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147) {
        is B($i++), $_;
    }

    done_testing;
    exit;
}
