#!/usr/bin/perl

use v5.32;
use Test2::V0 '!float', float => {-as => 'float2'};
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use PDL;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples);
my $length = 0;
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'length=i'  => \$length,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless 0 < $length <= @ARGV;

sub usage {
    die <<~EOS;
    $0 - Maximum Average

    usage: $0 [-examples] [-tests] [-length=L N...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -length=L
        subarray length
        
    N...
        list of numbers

    EOS
}


### Input and Output

say max_avg($length, @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/17/ch-304.html#task-2

sub max_avg ($n, @ints) {
    pdl(\@ints)->lags(0, 1, $n)->xchg(0, 1)->average->max->sclr;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub call_impl ($name, $args, $expected) {
        my $result = max_avg @$args;
        my $l = shift @$args;
        like $result, $expected,
            "$name: l=$l, (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            ['example 1', [4 ,=> 1, 12, -5, -6, 50, 3], float2(12.75)],
            ['example 2', [1 ,=> 5], number(5)],
        );
        plan scalar @examples;
        for (@examples) {
            call_impl @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;

        is max_avg(2 ,=> 2, 2, 1), 2, 'first subarray';
        is max_avg(2 ,=> 1, 2, 2), 2, 'last subarray';
    }) : pass 'skip tests';

    exit;
}
