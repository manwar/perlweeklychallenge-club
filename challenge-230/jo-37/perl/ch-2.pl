#!/usr/bin/perl -s

use v5.24;
use Test2::V0;

our ($tests, $examples, $verbose, $prefix);
$prefix //= '';

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-prefix=PRE] [STR...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print matching strings instead of their count

-prefix=PRE
    use PRE as the prefix. Default: ''

STR...
    list of strings

EOS


### Input and Output

if ($verbose) {
    say for common_prefix($prefix, @ARGV);
} else {
    say scalar common_prefix($prefix, @ARGV);
}


### Implementation

# Match strings starting with the given prefix literally.
sub common_prefix {
	my $prefix = shift;
    grep /^\Q$prefix\E/, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar(common_prefix(qw(at pay attention practice attend))), 2,
            'example 1';

        is scalar(common_prefix(qw(ja janet julia java javascript))), 3,
            'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is [common_prefix(".", ".a", "aa")], [".a"], 'regex prefix';
	}

    done_testing;
    exit;
}
