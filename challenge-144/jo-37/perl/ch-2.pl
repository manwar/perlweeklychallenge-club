#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Math::Prime::Util qw(vecsum forcomb vecmin);
use List::MoreUtils qw(singleton);
use List::Gen qw(:iterate);
use experimental 'signatures';

our ($tests, $examples, $count);
$count ||= 10;

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [-count=C] [U1 U2]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-count=C
    print the first C elements of the Ulam Sequence. Default: 10

U1 U2
    starting elements of an Ulam Sequence

EOS


### Input and Output

gen_ulam(@ARGV)->say($count);


### Implementation

# Build a generator for an Ulam Sequence defined by the two starting
# elements. 
sub gen_ulam ($u1, $u2) {
    ([$u1, $u2] + iterate {
            # The last accessed index of the sequence is the last index
            # of the sequence's head plus the current index in the
            # "iterate" generator.
            my $i = $_ + 1;
            my @sums;
            # Collect the sums of all pairs of already seen elements.
            forcomb {push @sums, vecsum self()->slice(@_)} $i + 1, 2;
            # Take the minimum unique sum larger than the last seen
            # element.
            vecmin grep $_ > self($i), singleton @sums;
        })->cache->recursive;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gen_ulam(1, 2)->take(10), [1, 2, 3, 4, 6, 8, 11, 13, 16, 18],
        'example 1';

        is gen_ulam(2, 3)->take(10), [2, 3, 5, 7, 8, 9, 13, 14, 18, 19],
        'example 2';

        is gen_ulam(2, 5)->take(10), [2, 5, 7, 9, 11, 12, 13, 15, 19, 23],
        'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        is gen_ulam(1, 2)->take(59), [1, 2, 3, 4, 6, 8, 11, 13, 16, 18,
            26, 28, 36, 38, 47, 48, 53, 57, 62, 69, 72, 77, 82, 87, 97,
            99, 102, 106, 114, 126, 131, 138, 145, 148, 155, 175, 177,
            180, 182, 189, 197, 206, 209, 219, 221, 236, 238, 241, 243,
            253, 258, 260, 273, 282, 309, 316, 319, 324, 339],
        'https://oeis.org/A002858';
	}

    done_testing;
    exit;
}
