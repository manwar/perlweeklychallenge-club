#!/usr/bin/perl -s

use v5.10;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV > 4;
usage: $0 [-examples] [-tests] [-verbose] [--] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print intermediate results and the detected recurrence from the
    first elements

N...
    five or more integers

EOS


### Input and Output

say is_lin_recur_2(@ARGV) ? 'true' : 'false';


### Implementation

sub logv {
    printf @_ if $verbose;
}

sub is_lin_recur_2 {
    my $a = pdl @_;
    logv "a: %s\n", $a;
    my $m = cat $a(0:1), $a(1:2);
    logv "M: %s\n", $m;
    if ($m->determinant) {
        my $p = $m->inv x $a(2:3)->transpose;
        logv "p: %s\n", $p;
        logv "recur: a[n] = %g * a[n-2] + (%g * a[n-1])\n", $p->list;
        return all(approx $p, $p->rint) &&
            all approx $a(4:), $p->transpose x cat $a(2:-3), $a(3:-2);
    }
    if ($a(1)) {
        my $p1 = $a(2) / $a(1);
        logv "recur: a[n] = %g * a[n-1]\n", $p1->sclr;
        return approx($p1, $p1->rint) && all approx $a(3:), $p1 * $a(2:-2);
    }

    logv "recur: a[n] = 0\n";
    return all $a(2:) == 0;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok  is_lin_recur_2(1, 1, 2, 3, 5),  'example 1';
        ok !is_lin_recur_2(4, 2, 4, 5, 7),  'example 2';
        ok  is_lin_recur_2(4, 1, 2, -3, 8), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok  is_lin_recur_2(1, 0, 0, 0, 0),     'order 0';
        ok !is_lin_recur_2(1, 0, 0, 1, 0),     'failed order 0, @ 3';
        ok !is_lin_recur_2(1, 0, 0, 0, 1),     'failed order 0, @ 4';
        ok !is_lin_recur_2(0, 0, 1, 0, 0),     'failed order 0, @ 2';
        ok  is_lin_recur_2(1, 2, 4, 8, 16),    'order 1';
        ok !is_lin_recur_2(1, 2, 4, 9, 16),    'failed order 1, @ 3';
        ok !is_lin_recur_2(1, 2, 4, 8, 15),    'failed order 1, @ 4';
        ok !is_lin_recur_2(81, 27, 9, 3, 1),   'failed order 1, non-integer';
        ok  is_lin_recur_2(1, 0, 2, 0, 4),     'order 2: a[n] = 2 * a[n-2]';
        ok  is_lin_recur_2(1, 1, 0, 0, 0),     'order 2: zeroes';
        ok !is_lin_recur_2(1, 1, 0, 0, 1),     'failed order 2, @ 4';
        ok  is_lin_recur_2(1, 0, 0, 0, 0, 0),  'order 0: six numbers';
        ok !is_lin_recur_2(1, 0, 0, 0, 0, 1),  'failed order 0: six numbers';
        ok  is_lin_recur_2(1, 1, 1, 1, 1, 1),  'order 1: six numbers';
        ok !is_lin_recur_2(1, 1, 1, 1, 1, 2),  'failed order 1: six numbers';
        ok  is_lin_recur_2(1, 1, 2, 3, 5, 8),  'order 2: six numbers';
        ok !is_lin_recur_2(1, 1, 2, 3, 5, 7),  'failed order 2: six numbers';
        ok  is_lin_recur_2(1, 1, 11, 21, 131), 'approximation required';
	}

    done_testing;
    exit;
}
