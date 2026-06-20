#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use Math::Prime::Util qw(fromdigits vecsum);


### Options and Arguments

my ($tests, $examples, $verbose, $base);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'base=i'    => \$base,
) or usage();

$base ||= 10;

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV > 2;

sub usage {
    die <<~EOS;
    $0 - sum of words

    usage: $0 [-examples] [-tests] [-base B] [WORD...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -base B
        use base B

    WORD...
        list of words

    EOS
}


### Input and Output

say +(qw(false true))[sum_of_words($base, @ARGV)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/06/18/ch-378.html#task-2

sub sum_of_words {
    my $base = shift;
    my @nums = map fromdigits([map ord() - 97, split //, $_], $base), @_;

    $nums[-1] == vecsum @nums[0 .. $#nums - 1];
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = sum_of_words(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[10 ,=> "acb", "cba", "cdb"], T(), 'example 1'],
            [[10 ,=> "aab", "aac", "ad"], T(), 'example 2'],
            [[10 ,=> "bc", "je", "jg"], F(), 'example 3'],
            [[10 ,=> "a", "aaaa", "aa"], T(), 'example 4'],
            [[10 ,=> "c", "d", "h"], F(), 'example 5'],
            [[10 ,=> "gfi", "hbf", "bdhd"], T(), 'example 6'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[2 ,=> "bb", "b", "baa"], T(), 'base 2'],
            [[16 ,=> "p", "b", "ba"], T(), 'base 16'],
            [[10 ,=> "b", "b", "b", "d"], T(), 'three summands'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
