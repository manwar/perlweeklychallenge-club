#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(pairvalues);
use List::MoreUtils qw(frequency);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [STR]

-examples
    run the examples from the challenge
 
-tests
    run some tests

STR
    a string

EOS


### Input and Output

say can_equalize(shift);


### Implementation

# Putting the cart before the horse:  If all characters are equally
# distributed and we add one character:
# - an existing frequency gets incremented or
# - a new frequency of '1' appears.
# Thus we can arrive at an equal distribution by removing one character
# if:
# - There is only one frequency.
# - There is a single frequency of '1' and all other are equally
#   distributed.
# - There is a single frequency with a value of one above the equally
#   distributed rest.
# Regarding the empty string as equally distributed.
sub can_equalize {
	my @f = sort {$a <=> $b} pairvalues frequency split //, shift;
    @f == 1 ||
        $f[0] == 1 && $f[1] == $f[-1] ||
        $f[-1] == $f[-2] + 1 && $f[0] == $f[-2];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        ok can_equalize('abbc'), 'example 1';
        ok can_equalize('xyzyyxz'), 'example 2';
        ok !can_equalize('xzxz'), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok can_equalize('zz'), 'single frequency';
        ok can_equalize('abbacdc'), 'singleton';
        ok can_equalize('q'), 'equalize to empty';
	}

    done_testing;
    exit;
}
