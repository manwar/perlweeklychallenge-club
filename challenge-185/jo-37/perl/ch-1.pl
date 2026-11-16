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
    $0 - convert MAC address

    usage: $0 [-examples] [-tests] [-verbose] [--] [MAC]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    MAC
        MAC address in format 'hhhh.hhhh.hhhh'

    EOS
}


### Input and Output

say conv_mac(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/15/ch-185.html#task-1

sub conv_mac {
    shift =~ s{
        ((?&HEX2))((?&HEX2))(\.?)
        (?(DEFINE)(?<HEX2>[0-9a-f]{2}))
    }
    {"$1:$2" . (":") x !!$3}gerx;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;
    plan 2;

    $examples ? subtest_streamed(examples => sub {
        plan 2;
        is conv_mac('1ac2.34f0.b1c2'), '1a:c2:34:f0:b1:c2', 'example 1';
        is conv_mac('abc1.20f1.345a'), 'ab:c1:20:f1:34:5a', 'example 2';
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
