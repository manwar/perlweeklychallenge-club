#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Set::Bag;
use List::MoreUtils 'frequency';
use List::Util qw(reduce pairmap);


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
    $0 - common characters

    usage: $0 [-examples] [-tests] [WORD...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    WORD...
        list of words

    EOS
}


### Input and Output

say "(@{[common_chars(@ARGV)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/22/ch-335.html#task-1


sub common_chars {
    pairmap {($a) x $b} (
        reduce {$a & $b} map Set::Bag->new(frequency split //), @_
    )->grab;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my @result = common_chars(@$args);
        my $exp = Test2::Compare::Bag->new;
        $exp->set_ending(1);
        $exp->add_item($_) for @$expected;
        like \@result, $exp,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["bella", "label", "roller"], [qw(e l l)], 'example 1'],
            [["cool", "lock", "cook"], [qw(c o)], 'example 2'],
            [["hello", "world", "pole"], [qw(l o)], 'example 3'],
            [["abc", "def", "ghi"], [], 'example 4'],
            [["aab", "aac", "aaa"], [qw(a a)], 'example 5'],
       );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["aabc"], [qw(a a b c)], 'single word'],
            [["höhle", "röhre"], [qw(e h ö)], 'umlauts'],
       );
        plan scalar @tests;
        for (@tests) {
            run_example @$_;
        }
    }) : pass 'skip tests';

    exit;
}
