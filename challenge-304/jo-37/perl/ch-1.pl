#!/usr/bin/perl

use v5.26;
use Test2::V0;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples, $n);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'replace=i' => \$n,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless $n && @ARGV;

sub usage {
    die <<~EOS;
    $0 - Arrange Binary

    usage: $0 [-examples] [-tests] [-replace=N B...]

    -help
        print this help text

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -replace=N
        try to replace N zeroes by ones

    B...
        list of binary digits

    EOS
}


### Input and Output

say +(qw(false true))[arrange_binary($n, @ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/17/ch-304.html#task-1

sub arrange_binary ($n, @bin) {
    for (join '', @bin) {
        return 0 if /11/;
        return $n <= (() = /(?:^|0)0(?!1)/g);
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub call_impl ($name, $args, $expected) {
        my $result = arrange_binary @$args;
        my $n = shift @$args;
        like $result, $expected,
            "$name: n=$n, (@$args) -> " . $expected->name;
    }

    state sub chk_limit ($n, @bin) {
        plan 2;

        ok  arrange_binary($n, @bin), "can $n";
        $n++;
        ok !arrange_binary($n, @bin), "not $n"; 
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            ['example 1', [1 ,=> 1, 0, 0, 0, 1], T()],
            ['example 2', [2 ,=> 1, 0, 0, 0, 1], F()],
        );
        plan scalar @examples;
        for (@examples) {
            call_impl @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 7;

        ok !arrange_binary(1 ,=> 1, 1, 0, 0), 'double one';
        subtest 'at begin',    \&chk_limit, 2 ,=> 0, 0, 1, 0, 0, 0, 1;
        subtest 'at end',      \&chk_limit, 2 ,=> 1, 0, 0, 0, 1, 0, 0;
        subtest 'even',        \&chk_limit, 1 ,=> 1, 0, 0, 0, 1, 0, 0, 1;
        subtest 'four zeros',  \&chk_limit, 1 ,=> 1, 0, 0, 0, 0, 1;
        subtest 'five zeros',  \&chk_limit, 2 ,=> 1, 0, 0, 0, 0, 0, 1;
        subtest 'single zero', \&chk_limit, 1 ,=> 0;
    }) : pass 'skip tests';

    exit;
}
