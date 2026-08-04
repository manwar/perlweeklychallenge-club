#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Gather;


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
    $0 - special binary substrings

    usage: $0 [-examples] [-tests] [B]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    B
        a binary string

    EOS
}


### Input and Output

say "(@{[sbs(shift)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/07/31/ch-384.html#task-2

sub sbs ($str) {
    gather {
        for my $b (@{[qw(01 10)]}) {
            while () {
                last if index($str, $b) < 0;
                take $b;
                $b = substr($b, 0, 1) . $b . substr($b, -1);
            }
        }
    };
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = sbs(@$args);
        is \@result, $expected,
            "$name: (@$args) -> " . 
            join ' ', map "$_->{expect}", $expected->items->@*;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["0101"],
                bag {item "01"; item "10"; end},
                    'example 1'],
            [["000111"],
                bag {item "000111"; item "0011"; item "01"; end},
                    'example 2'],
            [["000011"],
                bag {item "0011"; item "01"; end},
                    'example 3'],
            [["10011100"],
                bag {item "10"; item "0011"; item "01"; item "1100"; end},
                    'example 4'],
            [["00000"], bag {end}, 'example 5'],
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
