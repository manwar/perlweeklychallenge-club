#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'part';
use Math::Prime::Util qw(fromdigits todigits vecmax);

use constant BASE => 10;

### Options and Arguments

my ($tests, $examples, $verbose, $base);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'base=i'    => \$base,
) or usage();

$base //= 10;

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - same digits

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -base=B
        find same digits in base B representation

    N
        a non-negative number

    EOS
}


### Input and Output

say same_digits($base, shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/22/ch-374.html#task-2

sub same_digits ($base, $num) {
    vecmax map fromdigits($_//[0], $base), part {$_} todigits $num, $base;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = same_digits(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[10, 6777133339], 3333, 'example 1'],
            [[10, 1200034], 4, 'example 2'],
            [[10, 44221155], 55, 'example 3'],
            [[10, 88888], 88888, 'example 4'],
            [[10, 11122233], 222, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        is same_digits(3, 1312), 40, 'ternary';
    }) : pass 'skip tests';

    exit;
}
