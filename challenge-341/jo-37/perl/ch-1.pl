#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples, $verbose, $broken);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'broken=s'  => \$broken,
) or usage();

$broken //= '';

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - broken keys

    usage: $0 [-examples] [-tests] [-verbose] [--] [-broken BROKEN] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -broken BROKEN
        string containing the broken keys

    STR
        string or list of words

    EOS
}


### Input and Output

say scalar broken_keys([split //, $broken], "@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/17/ch-341.html#task-1

sub broken_keys {
    my $typeable = qr{^[^\s@{+shift}]+$}ixx;

    grep /$typeable/, split /\s+/, shift;
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = broken_keys(@$args);
        is $result, $expected,
            "$name: (($args->[0]->@*), '$args->[1]') -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[qw(d)], 'Hello World'], 1, 'example 1'],
            [[[qw(a e)], 'apple banana cherry'], 0, 'example 2'],
            [[[], 'coding is fun'], 3, 'example 3'],
            [[[qw(a b)], 'The weekly challenge'], 2, 'example 4'],
            [[[qw(p)], 'Perl and Python'], 1, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
