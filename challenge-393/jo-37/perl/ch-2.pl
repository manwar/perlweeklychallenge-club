#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(vecsum vecmin is_prime next_prime prev_prime);

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - prime step

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say prime_step(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/04/ch-393.html#task-2

sub prime_step {
    my $csum = vecsum map ord, split //, shift;
    is_prime($csum) ?
        0 :
        vecmin $csum - prev_prime($csum), next_prime($csum) - $csum;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = prime_step(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['hello'],     9, 'example 1'],
            [['football'],  2, 'example 2'],
            [['a'],         0, 'example 3'],
            [['challenge'], 2, 'example 4'],
            [['perl'],      2, 'example 5'],
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
