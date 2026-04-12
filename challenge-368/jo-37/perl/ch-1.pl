#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(fromdigits todigits vecmax);
use List::Gather;

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - make it bigger

    usage: $0 [-examples] [-tests] [NUM D]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    NUM
        a positive integer
    D
        a decimal digit

    EOS
}


### Input and Output

say bigger(@ARGV[1, 0]) // $ARGV[0];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/04/12/ch-368.html#task-1

sub bigger {
    my ($c, @tail, @head) = (shift, todigits(shift, 10));
    vecmax gather {
        while (@tail) {
            my $d = shift @tail;
            take fromdigits([@head, @tail], 10) if $d == $c;
            push @head, $d
        }
    };
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = bigger(@$args);
        is $result, $expected,
            "$name: (@$args) ->  $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[5, 15456], 1546, 'example 1'],
            [[3, 7332], 732, 'example 2'],
            [[2, 2231], 231, 'example 3'],
            [[5, 543251], 54321, 'example 4'],
            [[1, 1921], 921, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
