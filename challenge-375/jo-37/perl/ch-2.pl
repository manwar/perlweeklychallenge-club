#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(todigitstring fromdigits);


### Options and Arguments

my ($tests, $examples, $verbose, $base, $k);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'base=i'    => \$base,
    'k=i'       => \$k,
) or usage();

$base //= 10;

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - K-Beauty

    usage: $0 [-examples] [-tests] [-verbose] [-base B] [-k K NUM]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        print divisors

    -base B
        use base B

    -k K
        find K-Beauty

    NUM
        positive integer

    EOS
}


### Input and Output

main: {
    my @beauty = beauty(shift, $k, $base);
    say $verbose ? "@beauty" : scalar @beauty;
}


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/29/ch-375.html#task-2

sub beauty ($num, $k, $base) {
    grep 0 + $_ && !($num % fromdigits($_, $base)),
        todigitstring($num, $base) =~ /(?=(.{$k}))./g;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = beauty(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[240, 2, 10], 2, 'example 1'],
            [[1020, 2, 10], 3, 'example 2'],
            [[444, 2, 10], 0, 'example 3'],
            [[17, 2, 10], 1, 'example 4'],
            [[123, 1, 10], 2, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        is scalar beauty(30030, 4, 2), 10, '30030 binary, k=4';
        is scalar beauty(30030, 5, 2),  7, '30030 binary, k=5';
    }) : pass 'skip tests';

    exit;
}
