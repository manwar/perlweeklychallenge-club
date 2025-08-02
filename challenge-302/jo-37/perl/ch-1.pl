#!/usr/bin/perl -s

use v5.24;
use Test2::V0 "!float";
use PDL;
use PDL::NiceSlice;
use PDL::Opt::GLPK;
use experimental 'signatures';

our ($tests, $examples, $verbose, $x, $y);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && $x && $y;
usage: $0 [-examples] [-tests] [-verbose] [-x=X -y=Y B...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print GLPK informational output

-x=X
    maximum number of zeroes

-y=Y
    maximum number of ones

B...
    list of binary strings

EOS


### Input and Output

say ones_and_zeroes($x, $y, @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/03/ch-302.html#task-1

sub ones_and_zeroes ($x, $y, @str) {
    my $a = long(
        [map {my $c = tr/0/0/} @str],
        [map {my $c = tr/1/1/} @str]
    );
    my $one = ones($a(,(0)));
    my $opt = {msglev => $verbose ? GLP_MSG_ALL : GLP_MSG_ERR};

    glpk($one, $a, long($x, $y), $one, $one,
        long(GLP_UP, GLP_UP), GLP_BV * $one, GLP_MAX,
        null, my $fopt = null, my $status = null, $opt);
    die "glpk returned $status\n" unless $status == GLP_OPT;
    
    $fopt;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is ones_and_zeroes(5, 3, "10", "0001", "111001", "1", "0"),
            4, 'example 1';

        is ones_and_zeroes(1, 1, "10", "1", "0"), 2, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $n = 64;
        my @str;
        push @str, "1" x $_ . "0" x ($n - $_) for 1 .. $n;
        my $x = ($n - 1) * $n / 4;
        my $y = ($n + 1) * $n / 4;
        is ones_and_zeroes($x, $y, @str), $n / 2, "one half of $n";
    }

    done_testing;
    exit;
}
