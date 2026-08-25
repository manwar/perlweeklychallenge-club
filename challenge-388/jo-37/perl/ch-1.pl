#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Memoize;
use List::Gather;


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
    $0 - Dyck Words

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        a nonnegative integer

    EOS
}


### Input and Output

say "@{[dyck_words(shift)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/08/28/ch-388.html#task-1

sub dyck_words {
    state sub eq_ud :prototype(_) {
        return tr/U// == tr/D// for shift;
    }

    state $dp;
    $dp //= memoize sub ($k) {
        return '' unless $k;
        gather {
            take +($_.'D') x !eq_ud, $_.'U' for $dp->($k - 1);
        };
    };

    grep eq_ud, $dp->(2 * shift);
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = dyck_words(@$args);
        is \@result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1], ["UD"], 'example 1'],
            [[2], ["UDUD","UUDD"], 'example 2'],
            [[3], ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"],
                'example 3'],
            [[0], [""], 'example 4'],
            [[4], ["UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD",
                    "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD",
                    "UUDUDUDD", "UUDUUDDD", "UUUDDDUD", "UUUDDUDD",
                    "UUUDUDDD", "UUUUDDDD"], 'example 2'],
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
