#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'max';

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
    $0 - maximum string value

    usage: $0 [-examples] [-tests] [STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR...
        list of strings

    EOS
}


### Input and Output

say max_str(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/30/ch-358.html#task-1

sub max_str {
    max map /^\d+$/ ? $_ : length, @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = max_str(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[123, 45, 6], 123, 'example 1'],
            [["abc", "de", "fghi"], 4, 'example 2'],
            [["0012", "99", "a1b2c"], 99, 'example 3'],
            [["x", "10", "xyz", "007"], 10, 'example 4'],
            [["hello123", "2026", "perl"], 2026, 'example 5'],

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
