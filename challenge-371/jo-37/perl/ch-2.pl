#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(vecsum forcomb);
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
    $0 - subset equilibrium

    usage: $0 [-examples] [-tests] [--] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        enable trace output

    N...
        list of numbers

    EOS
}


### Input and Output

say join ' ', map "(@$_)", subset_eq(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/01/ch-371.html#task-2

sub subset_eq (@nums) {
    gather {
        forcomb {
            take [@nums[@_]] if @_ && vecsum(@_) + @_ == vecsum(@nums[@_]);
        } @nums;
    };
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = subset_eq(@$args);
        is \@result, $expected,
            "$name: (@$args) -> " .
            join ' ', map "[$_->{expect}->@*]", $expected->items->@*;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[2, 1, 4, 3], bag {item [2, 1]; item [1, 4];
                    item [4, 3]; item [2, 3]; etc}, 'example 1'],
            [[3, 0, 3, 0], bag {item [3, 0]; item [3, 0, 3]; etc},
                'example 2'],
            [[5, 1, 1, 1], bag {item [5, 1, 1]; end}, 'example 3'],
            [[3, -1, 4, 2], bag {item [3, 2]; item [3, -1, 4]; end},
                'example 4'],
            [[10, 20, 30, 40], bag {}, 'example 5'],
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
