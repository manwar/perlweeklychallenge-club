#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use Lingua::EN::Words2Nums;


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
    $0 - string lie detector

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        self-referential string of the form
        "SUBJECT PD X vowel[s] and Y consonant[s]"
        where PD is any character having the Unicode property
        "Dash_Punctuation"

    EOS
}


### Input and Output

say +(qw(true false))[!string_lie_detector(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/03/06/ch-363.html#task-1

sub string_lie_detector {
    my ($subject, $vowels, $consonants) =
        lc(shift) =~ /^(.*?)\s\p{Pd}\s(.*?) vowels? and (.*?) consonants?$/
        or return;
    words2nums($vowels) == $subject =~ tr/aeiou// or return;
    words2nums($consonants) == $subject =~ tr/bcdfghjklmnpqrstvwxyz// or return;
    1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = string_lie_detector(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["aa — two vowels and zero consonants"], T(), 'example 1'],
            [["iv — one vowel and one consonant"], T(), 'example 2'],
            [["hello - three vowels and two consonants"], F(), 'example 3'],
            [["aeiou — five vowels and zero consonants"], T(), 'example 4'],
            [["aei — three vowels and zero consonants"], T(), 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["Awwwwwwwwwwwww! \N{EM DASH} One vowel and thirteen consonants"],
                T(), 'larger number, upper case, extra character'],
            [["abcdefghi \N{HYPHEN} three vowels and six consonants"], T(),
                'HYPHEN'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
