#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(fromdigits todigits prime_iterator);
use Syntax::Keyword::Gather;
use experimental 'signatures';

our ($tests, $examples, $base);
$base ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-base=B
    find palindrome numbers in base B

N
   print all prime palindrome numbers not larger than N

EOS


### Input and Output

say for prime_palindrome(shift, $base);


### Implementation

# Collect all prime palindrome numbers in base $base not larger than $n
sub prime_palindrome ($n, $base) {
    gather {
        my $pi = prime_iterator;
        while ((my $p = $pi->()) <= $n) {
            take $p if $p == fromdigits [reverse todigits $p, $base], $base;
        }
    }
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is scalar(prime_palindrome(1000, 10)), 
            [2, 3, 5, 7, 11, 101, 131, 151, 181, 191, 313, 353, 373,
                383, 727, 757, 787, 797, 919, 929],
            'task 1 according to http://oeis.org/A002385';
    }

    SKIP: {
        skip "tests" unless $tests;

        is scalar(prime_palindrome(10000, 6)),
            [2, 3, 5, 7, 37, 43, 61, 67, 191, 197, 1297, 1627, 1663,
                1699, 1741, 1777, 1999, 2143, 2221, 2293, 2551, 6521,
                6779, 7001, 7109, 7151, 7187, 7331, 7481, 7517, 7703],
            'see http://oeis.org/A029974';
	}

    done_testing;
    exit;
}
