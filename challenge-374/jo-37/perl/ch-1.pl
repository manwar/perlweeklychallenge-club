#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::UtilsBy 'max_by';
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
    $0 - vowel substring

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say vowel_substr(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/22/ch-374.html#task-1

sub vowel_substr {
    state $vows = [qw(a e i o u)];
    state $vowcl = qr{[@$vows]}ixx;
    state $vowsahead = [map qr{(?=($vowcl*?$_))}i, @$vows];

    gather {
        shift =~ m{
            @$vowsahead
            (
                (??{max_by {length} @{^CAPTURE}})
                $vowcl*
            )
            (?{take $+})
            (*FAIL)
        }x;
    };
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = vowel_substr(@$args);
        is \@result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["aeiou"], ["aeiou"], 'example 1'],
            [["aaeeeiioouu"],
               ["aaeeeiioouu","aaeeeiioou","aeeeiioouu","aeeeiioou"],
               'example 2'],
            [["aeiouuaxaeiou"],
               ["aeiouua", "aeiouu", "aeiou", "eiouua", "aeiou"],
               'example 3'],
            [["uaeiou"], ["uaeiou", "uaeio", "aeiou"], 'example 4'],
            [["aeioaeioa"], [], 'example 5'],
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
