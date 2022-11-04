#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util 'reduce';

our ($tests, $examples, $target);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless $target && @ARGV;
usage: $0 [-examples] [-tests] [-target=t] [--] [C...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-target=t
    use t as target character

C...
    some characters

EOS


### Input and Output

say smallest_char($target, @ARGV);


### Implementation

# Example 5 contradicts the task's description as 'v' is not contained
# in the given array.  Implementing according to the example anyways as
# it is an interesting twist.
sub smallest_char {
    my $t = shift;
    # Select a new candidate if it is larger than the target and smaller
    # than an existing previous candidate.  Initializing $a with the
    # target gives the target as result if there is no matching
    # character in the array.
	reduce {$b gt $t && ($b lt $a || $a eq $t) ? $b : $a} $t, @_;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is smallest_char(qw(b e m u g)), 'e', 'Example 1';
        is smallest_char(qw(a d c e f)), 'c', 'Example 2';
        is smallest_char(qw(o j a r)),   'r', 'Example 3';
        is smallest_char(qw(a d c a f)), 'c', 'Example 4';
        is smallest_char(qw(v t g a l)), 'v', 'Example 5';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
