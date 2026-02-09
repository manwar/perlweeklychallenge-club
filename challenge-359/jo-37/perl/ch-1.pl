#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(todigits vecsum);


### Options and Arguments

my ($tests, $examples, $verbose, $base);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'base=i'    => \$base,
) or usage();

$base ||= 10;

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - digital root

    usage: $0 [-examples] [-tests] [-base B] [I]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -base B
        use base B. Default: 10

    I
        an integer

    EOS
}


### Input and Output

printf "Persistence  = %d\nDigital Root = %d\n", digital_root(shift, $base);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/02/06/ch-359.html#task-1

sub digital_root ($int, $base) {
    use bigint;
    my $persistence = 0;
    $persistence++, $int = vecsum todigits $int, $base while $int >= $base;

    ($persistence, $int);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [digital_root(@$args)];
        is $result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[38, 10], [2, 2], 'example 1'],
            [[7, 10], [0, 7], 'example 2'],
            [[999, 10], [2, 9], 'example 3'],
            [[1999999999, 10], [3, 1], 'example 4'],
            [[101010, 10], [1, 3], 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is [digital_root(127, 8)], [3, 1], 'smallest p=3, b=8';
        is [digital_root('19999999999999999999999', 10)], [4, 1],
            'smallest p=4, b=10';
        is [digital_root('170141183460469231731687303715884105727', 2)],
            [5, 1], 'smallest p=5, b=2';
    }) : pass 'skip tests';

    exit;
}
