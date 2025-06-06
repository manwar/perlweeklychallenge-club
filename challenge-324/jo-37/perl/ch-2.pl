#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - total xor

    usage: $0 [-examples] [-tests] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of integers

    EOS
}


### Input and Output

say total_xor(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/06/06/ch-324.html#task-2

sub total_xor {
    longlong(@_)->bor->shiftleft(@_ - 1);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = total_xor(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 3], 6, 'example 1'],
            [[5, 1, 6], 28, 'example 2'],
            [[3 .. 8], 480, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is total_xor(1, 1, 1), 4, 'example from blog';
        is total_xor((1) x 32), 2**31, 'some more ones';

        # cross check on random bits from random ints:
        # perl -Mntheory=:all -E 'forcomb {$s = 0; $s ^= $ARGV[$_] for @_; $t += $s} @ARGV; say $t' 33600 541464 573584 557328 49616 525596 49372 34636 575368 575316 50640 1228 34112 1472 542020 557776 575112 557660 17988 33996
        is total_xor(33600, 541464, 573584, 557328, 49616, 525596,
            49372, 34636, 575368, 575316, 50640, 1228, 34112, 1472,
            542020, 557776, 575112, 557660, 17988, 33996),
            301702578176, 'cross check';
    }) : pass 'skip tests';

    exit;
}
