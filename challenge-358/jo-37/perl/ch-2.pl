#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use String::Compile::Tr;

### Options and Arguments

my ($tests, $examples, $verbose, $key);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'key=i'     => \$key,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless defined $key && @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - encrypt string

    usage: $0 [-examples] [-tests] [-key K STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -key K
        encryption key

    STR
        a string

    EOS
}


### Input and Output

say encrypt(shift, $key);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/30/ch-358.html#task-2

sub encrypt ($str, $int) {
    state $alpha = join '', 'a' .. 'z';
    $int %= length $alpha;
    my $enc = substr($alpha, $int) . substr($alpha, 0, $int);
    trgen($alpha, $enc, 'r')->($str);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = encrypt(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['abc', 1], 'bcd', 'example 1'],
            [['xyz', 2], 'zab', 'example 2'],
            [['abc', 27], 'bcd', 'example 3'],
            [['hello', 5], 'mjqqt', 'example 4'],
            [['perl', 26], 'perl', 'example 5'],
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
