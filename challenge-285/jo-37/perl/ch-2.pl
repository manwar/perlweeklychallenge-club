#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [AMOUNT]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    print all individual combinations

AMOUNT
    amount

EOS


### Input and Output

if ($verbose) {
    my $n;
    say "${\(++$n)}: ", fmt(@$_) for make_change(shift);
} else {
    say scalar make_change(shift);
}



### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/09/06/ch-285.html#task-2

sub make_change ($amount, $coin = 4) {
    state $coins = [1, 5, 10, 25, 50];
	if ($coin == 0) {
        if ($amount % $coins->[0] == 0) {
            return [$amount / $coins->[0]];
        } else {
            return ();
        }
    }
    my @comb;
    for (my ($cnt, $val) = (0, 0);
            $val <= $amount;
            $cnt++, $val += $coins->[$coin]) {
        if ($val == $amount) {
            push @comb, [(0) x $coin, $cnt];
        } else {
            push @comb, [@$_, $cnt]
                for make_change($amount - $val, $coin - 1);
        }
    }

    @comb;
}

sub fmt {
    state $name = [qw(P N D Q HD)];
    my @coins;
    for (my $i = $#_; $i >= 0; $i--) {
        my $c = $_[$i];
        push @coins, $c x ($c != 1) . $name->[$i] if $c;
    }

    join ' + ', @coins;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is [make_change(9)], [[9, 0, 0, 0, 0], [4, 1, 0, 0, 0]], 'example 1';
        is [make_change(15)], [
            [15, 0, 0, 0, 0],
            [10, 1, 0, 0, 0],
            [5, 2, 0, 0, 0],
            [0, 3, 0, 0, 0],
            [5, 0, 1, 0, 0],
            [0, 1, 1, 0, 0],
        ], 'example 2';
        is make_change(100), 292, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
