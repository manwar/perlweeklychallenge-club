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

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - valid token counter

    usage: $0 [-examples] [-tests] [-verbose] [STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        print valid tokens instead of counting them

    STR
        a string

    EOS
}


### Input and Output


say $verbose ?
    valid_token_counter("@ARGV") :
    scalar 0 + valid_token_counter("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/20/ch-365.html#task-2

sub valid_token_counter {
    my $digit = qr{.*\d};
    my $pre_h = qr{.*-(?<!\p{Ll}.)};
    my $post_h = qr{.*-(?!\p{Ll})};
    my $multi_h = qr{.*-.*-};
    my $punct = qr{.*[!.,].};
    my $valid = qr{
        ^
        (?!$digit)
        (?!$pre_h)
        (?!$post_h)
        (?!$multi_h)
        (?!$punct)
    }x;
    grep /$valid/, split /\s+/, shift;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = valid_token_counter(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["cat and dog"],              3, 'example 1'],
            [["a-b c! d,e"],               2, 'example 2'],
            [["hello-world! this is fun"], 4, 'example 3'],
            [["ab- cd-ef gh- ij!"],        2, 'example 4'],
            [["wow! a-b-c nice."],         2, 'example 5'],
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
