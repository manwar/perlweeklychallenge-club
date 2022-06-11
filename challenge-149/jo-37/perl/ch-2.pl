#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Util qw(max pairvalues);
use List::MoreUtils 'frequency';
use Math::Prime::Util qw(fromdigits todigits todigitstring);
use experimental 'signatures';

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [base]

-examples
    run the examples from the challenge

base
    Find the largest perfect square having no repeated digits in the
    given base. 

EOS


### Input and Output

# Print the largest square in the requested base.
say todigitstring(max_square($ARGV[0]), $ARGV[0]);


### Implementation

# The maximum number having no repeated digits in a given base is the
# number built from all digits in descending order.  Trying all perfect
# squares down from this maximum.
#
# Returns an integer, not the requested string.
sub max_square ($base) {
    for (my $r = int sqrt fromdigits [reverse 0 .. $base - 1], $base;; $r--) {
        my $k = $r ** 2;
        return $k if 1 == max pairvalues frequency todigits $k, $base;
    }
}



### Examples and tests

sub run_tests {
    is todigitstring(max_square(2), 2), '1', 'example 1';
    is todigitstring(max_square(4), 4), '3201', 'example 2';
    is max_square(10), 9814072356, 'example 3';
    like todigitstring(max_square(12), 12), qr/^B8750A649321$/i, 'example 4';

    done_testing;
    exit;
}
