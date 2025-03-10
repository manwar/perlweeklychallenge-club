#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::Char;
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
    $0 - minimum time

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string of characters 'a' .. 'z'

    EOS
}


### Input and Output

say minimum_time(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/03/14/ch-312.html#task-1


sub minimum_time ($str) {
    return 0 unless $str;
    my $s = PDL::Char->new("a$str")->long;
    sum 14 - abs(abs($s(1:-1) - $s(0:-2)) - 13);
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = minimum_time(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['abc'], 5, 'example 1'],
            [['bza'], 7, 'example 2'],
            [['zjpc'], 34, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        is minimum_time(''), 0, 'nothing to print';
        is minimum_time('a'), 1, 'single "a"';
    }) : pass 'skip tests';

    exit;
}
