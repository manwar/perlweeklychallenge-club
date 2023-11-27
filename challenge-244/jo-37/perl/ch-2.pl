#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use bigint;

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of numbers

EOS


### Input and Output

say total_power(@ARGV);


### Implementation

sub total_power {
    my @s = sort {$a <=> $b} @_;
    my $power;
    while (defined (my $min = $s[0])) {
        while (my ($offs, $max) = each @s) {
            $power += $min * $max**2 * ($offs ? 2**($offs - 1) : 1);
        }
    } continue {
        shift @s;
    }

    $power;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is total_power(2, 1, 4), 141, 'example 1';
    }

    SKIP: {

        is total_power(2, 3, 5, 7), 1627, 'example from blog';
        is total_power((2) x 64), (2**64 - 1) * 2 * 2**2,
            '147573952589676412920';
	}

    done_testing;
    exit;
}
