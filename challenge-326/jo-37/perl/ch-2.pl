#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL 2.017;

### Options and Arguments

my ($tests, $examples, $compress, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'compress!' => \$compress,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - (de)compressed list

    usage: $0 [-examples] [-tests] [-compress] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -compress
        create a compressed list

    N...
        list of integers

    EOS
}


### Input and Output

say $compress ? compressed_list(@ARGV) : decompressed_list(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/06/18/ch-326.html#task-2


sub decompressed_list {
    rld long(@_)->splitdim(0, 2)->xchg(0, 1)->dog;
}

sub compressed_list {
    cat(rle long @_)->xchg(0, 1)->clump(2);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = decompressed_list(@$args)->unpdl;
        is $result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1, 3, 2, 4], [3, 4, 4], 'example 1'],
            [[1, 1, 2, 2], [1, 2, 2], 'example 2'],
            [[3, 1, 3, 2], [1, 1, 1, 2, 2, 2], 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is compressed_list(3, 4, 4)->unpdl, [1, 3, 2, 4],
            'compress example 1';
        is compressed_list(1, 2, 2)->unpdl, [1, 1, 2, 2],
            'compress example 2';
        is compressed_list(1, 1, 1, 2, 2, 2)->unpdl, [3, 1, 3, 2],
            'compress example 3';
    }) : pass 'skip tests';

    exit;
}
