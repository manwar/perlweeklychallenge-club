#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Unicode::Normalize;

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
    $0 - word count

    usage: $0 [-examples] [-tests] [W...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    W...
        list of words

    EOS
}


### Input and Output

say word_count(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/05/02/ch-319.html#task-1


sub word_count {
    scalar grep /^(?&VOWEL)|(?&VOWEL)\P{L}*$(?(DEFINE)(?<VOWEL>[aeiouøæœ]))/,
    map NFD(fc), @_;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = word_count(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["unicode", "xml", "raku", "perl"], 2, 'example 1'],
            [["the", "weekly", "challenge"], 2, 'example 2'],
            [["perl", "python", "postgres"], 0, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is word_count(qw(Öl Bö øre Øre knæ KNÆ œuf Proﬁ Ålborg)), 9, 'variants';
        is word_count("xaeiouÖöøØæÆœﬁÅx"), 0, 'cross check';
        is word_count(qw(hour Yttrium many)), 0, 'spoken vowels';
    }) : pass 'skip tests';

    exit;
}
