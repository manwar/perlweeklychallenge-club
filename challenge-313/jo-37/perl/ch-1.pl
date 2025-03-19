#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - check broken keys

    usage: $0 [-examples] [-tests] [--] [NAME TYPED]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    NAME
        the original string

    TYPED
        the typed string

    EOS
}


### Input and Output

say +(qw(true false))[!broken_keys(@ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/03/21/ch-313.html#task-1


sub broken_keys ($name, $typed) {
    $typed =~ /^(??{$name =~ s#.#\Q$&\E+#gr})$/;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = broken_keys(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['perl', 'perrrl'], T(), 'example 1'],
            [['raku', 'rrakuuuu'], T(), 'example 2'],
            [['python', 'perl'], F(), 'example 3'],
            [['coffeescript', 'cofffeescccript'], T(), 'example 4'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        is broken_keys('.', 'abc'), F(), 'ignore regex meta';
        is broken_keys('+*', '++**'), T(), 'match regex meta';
    }) : pass 'skip tests';

    exit;
}
