#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'part';
use List::Util 'mesh';

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
    $0 - balance string

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string containing letters and digits only

    EOS
}


### Input and Output

say balance_string(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/10/17/ch-342.html#task-1


sub balance_string ($str) {
    my @parts = part {/\D/} sort split //, $str;
    my $ld = $parts[1]->@* - $parts[0]->@*;
    return '' if abs $ld > 1;
    join '', (mesh $ld > 0 ? reverse @parts : @parts)[0 .. length($str) - 1];
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = balance_string(@$args);
        is $result, $expected,
            "$name: ('@$args') -> '$expected'";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['a0b1c2'], '0a1b2c', 'example 1'],
            [['abc12'], 'a1b2c', 'example 2'],
            [['0a2b1c3'], '0a1b2c3', 'example 3'],
            [['1a23'], '', 'example 4'],
            [['ab123'], '1a2b3', 'example 5'],
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
