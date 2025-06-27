#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;


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
    $0 - minimum absolute difference pairs

    usage: $0 [-examples] [-tests] [--] [N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N...
        list of integers

    EOS
}


### Input and Output

say mad_pairs(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/06/27/ch-327.html#task-2


sub mad_pairs {
    my $i = long @_;
    my $diff = $i - $i(*1);
    my $adiff = abs($diff)->setbadif(ones($diff)->tricpy(1));

    $i->index(scalar whichND $adiff == $adiff->min)->qsort->qsortvec;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = mad_pairs(@$args);
        pdl_is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[4, 1, 2, 3], pdl([1, 2], [2, 3], [3, 4]), 'example 1'],
            [[1, 3, 7, 11, 15], pdl([[1, 3]]), 'example 2'],
            [[1, 5, 3, 8], pdl([1,3], [3,5]), 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
