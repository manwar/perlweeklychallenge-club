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

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - outermost parentheses

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

say outermost_parentheses(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/08/07/ch-385.html#task-2

sub outermost_parentheses {
    shift =~ s{
        (?<BP>
            \(
            (?&NP)
            (?:
                (?&BP)
                (?&NP)
            )*
            \)
        )
        (?(DEFINE)(?<NP>[^()]*+))
    }{substr $&, 1, -1}grex;
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = outermost_parentheses(@$args);
        is $result, $expected,
            qq{$name: "@$args" -> "$expected"};
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["()()()"],         "",           'example 1'],
            [["(((())))"],       "((()))",     'example 2'],
            [["(()())(())"],     "()()()",     'example 3'],
            [["()((()))()"],     "(())",       'example 4'],
            [["(()(()))(()())"], "()(())()()", 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["x(x(x)x)x"], "xx(x)xx", 'extra chars'],
            [["((("],       "(((",     'non-balanced'],
            [["))(("],      "))((",    'non-matching'],
            [[")())()("],   "))(",     'non-balanced outer'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
