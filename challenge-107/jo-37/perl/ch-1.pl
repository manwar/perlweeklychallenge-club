#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(fromdigits todigitstring forcomp);
use List::Util 'all';
use List::MoreUtils 'frequency';
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [base...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    include the decimal representation in the output

base...
    find self-descriptive numbers for given base(s)
    Call "$0 4 5" for the task's solution.

EOS


### Input and Output

for my $base (@ARGV) {
    say todigitstring($_, $base), " ($base) = $_ (10)" x !!$verbose
        for @{self_descriptive($base)};
}


### Implementation

# A self-descriptive number has (besides its self-descriptiveness) two
# basic properties: In the given base the sum of its digits equals the
# base and the least significant digit is zero.  These properties may be
# used to select candidates.  There are utility subroutines that iterate
# over compositions, i.e. all the (ordered) summands for a given sum.
# However, the smallest value for a summand in a composition is one.  If
# we add one to our digits, they are in the range 1 .. base and give a
# sum of 2*base.  Furthermore, the last summand becomes one (instead of
# zero) and so the (restricted) compositions consist of base - 1
# remaining summands with a sum of 2*base - 1.  Such a composition
# iteration is provided by Math::Prime::Util::forcomp.
# A candidate is self-descriptive, if it resembles its digit
# frequencies, which can be easily calculated using
# List::MoreUtils::frequency.
# Finally, assemble the digits into a number.  This extra step assures
# the correct processing of bases larger than 10.
#
sub self_descriptive ($base) {
    my @sd;
    forcomp {
        # Get the true digits in the range 0 .. $base - 1.
        my @digit = map $_ - 1, @_, 1;
        my %freq = frequency @digit;
        push @sd, fromdigits(\@digit, $base) if all {
            $digit[$_] ?
                $freq{$_} && $digit[$_] == $freq{$_} :
                !$freq{$_}
        } 0 .. $#digit;
    } 2 * $base - 1, {n => $base - 1, amax => $base};

    \@sd;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is self_descriptive(4), [100, 136], 'first two';
        is self_descriptive(5), [1425], 'third';
    }

    SKIP: {
        skip "tests" unless $tests;
        is self_descriptive(6), [], 'base 6';
        is self_descriptive(7), [389305], 'base 7';
        is self_descriptive(8), [8946176], 'base 8';
	}

    done_testing;
    exit;
}
