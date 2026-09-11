#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::Char;


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2 && $ARGV[1] > 0;

sub usage {
    die <<~EOS;
    $0 - order characters

    usage: $0 [-examples] [-tests] [STR K]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    K
        prefix size to select element from

    EOS
}


### Input and Output

say order_characters(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/09/11/ch-390.html#task-2

sub order_characters ($str, $k) {
    my $s = PDL::Char->new($str);
    ($k > 1 ? $s->qsort : $s->rotate(sequence $s->indx)->qsortvec)->atstr(0);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = order_characters(@$args);
        is $result, $expected,
            qq{$name: "@$args" -> "$expected"};
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["dbca", 1], "adbc", 'example 1'],
            [["geeks", 2], "eegks", 'example 2'],
            [["cbaed", 3], "abcde", 'example 3'],
            [["fedcba", 4], "abcdef", 'example 4'],
            [["perl", 1], "erlp", 'example 5'],
            [["oloolooo", 1], "looloooo", 'example 6'],
            [["oloooolo", 1], "looloooo", 'example 7'],
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
