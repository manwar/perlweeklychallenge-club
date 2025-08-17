#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;

### Options and Arguments

my ($tests, $examples, $verbose, $location);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'location=s' => \$location,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV && $location;

sub usage {
    die <<~EOS;
    $0 - nearest valid point

    usage: $0 [-examples] [-tests] [-location [X, Y,...] [X1, Y1,...]...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -location [X,Y]
        current location, e.g. [3,4] or 3,4

    [X1,Y1,...]...
        list of points
        e.g.  [1,2] [3,1] [2,4] [2,3] or '1,2;3,1;2,4;2,3'
    EOS
}


### Input and Output

say nearest_valid_point($location, "@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/17/ch-334.html#task-2


sub nearest_valid_point ($x, @points) {
    my $d = abs pdl(@points) - pdl($x);
    (my $valid = which !$d->minover)->isempty && return -1;
    $valid($d(,$valid)->sumover->minimum_ind)->sclr;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = nearest_valid_point(@$args);
        is $result, $expected,
            "$name: (@{[map qq([@$_]), @$args]}) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[3, 4] ,=> ([1, 2], [3, 1], [2, 4], [2, 3])], 2, 'example 1'],
            [[[2, 5] ,=> ([3, 4], [2, 3], [1, 5], [2, 5])], 3, 'example 2'],
            [[[1, 1] ,=> ([2, 2], [3, 3], [4, 4])],        -1, 'example 3'],
            [[[0, 0] ,=> ([0, 1], [1, 0], [0, 2], [2, 0])], 0, 'example 4'],
            [[[5, 5] ,=> ([5, 6], [6, 5], [5, 4], [4, 5])], 0, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[[1, 1, 1] ,=> ([0, 0, 0])], -1, 'no point in 3-d'],
            [[[1, 1, 1] ,=>
                    ([0, 0, 0],
                     [0, 0, 1], [0, 1, 0], [1, 0, 0],
                     [1, 1, 0], [1, 0, 1], [0, 1, 1])],
                4, 'cube'],
        );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
