#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use List::Util 'sum';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    check STR

EOS


### Input and Output

say +(qw(false true))[check_luhn(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/11/08/ch-290.html#task-2


sub check_luhn {
    my @n = reverse shift =~ /(\d)/g;
    my $f = 2;
    my @m = map {($_ * ($f = 3 - $f)) =~ /(\d)/g} @n;
    
    !(sum(@m) % 10);
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  check_luhn("17893729974"), "example 1";
        ok  check_luhn("4137 8947 1175 5904"), "example 2";
        ok !check_luhn("4137 8974 1175 5904"), "example 3";
    }

    SKIP: {
        skip "tests" unless $tests;
    }

    done_testing;
    exit;
}
