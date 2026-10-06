#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util 'uniqstr';
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

usage() unless @ARGV > 1;

sub usage {
    die <<~EOS;
    $0 - alternating vowels and consonants

    usage: $0 [-examples] [-tests] [STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR...
        list of at least two alphabetic strings

    EOS
}


### Input and Output

say "(@{[alt_vow_cons(@ARGV)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/09/ch-394.html#task-2

sub alt_vow_cons {
    $_[0] =~ tr/a-zA-Z//c && die 'non-letter character';

    max_by {length} uniqstr gather {
        join("\n", @_) =~ m{
            (
                (?&VOW)(*MARK:NEXT)(?:(?&CONS)(?&VOW))*(?&CONS)?
                |
                (?&CONS)(*MARK:NEXT)(?:(?&VOW)(?&CONS))*(?&VOW)?
                |
                \n(*COMMIT)(*FAIL)
            )
            .*+
            (?: \n .*? \1 .*+)++ $
            (*SKIP:NEXT)
            (?{take $1})
            (*FAIL)
            (?(DEFINE)
                (?<VOW>[aeiou])
                (?<CONS>[^aeiou\n])
            )
        }xi;
    };
}


### Examples and Tests

sub run_tests ($examples, $tests) {
return unless $examples || $tests;

state sub run_example ($args, $expected, $name, $reason=undef) {
    my $todo = $reason ? todo $reason : undef;
        my @result = alt_vow_cons(@$args);
        is \@result, $expected,
            "$name: (@$args) -> (@$expected)";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["relocate", "delocate", "allocate"], ["locate"], 'example 1'],
            [["apple", "banana", "cherry"], [], 'example 2'],
            [["navigate", "cavity", "gravity"], ["avi"], 'example 3'],
            [["pedalgia", "pedalboard", "pedantic"], ["peda"], 'example 4'],
            [["schoolmaster", "schoolhouse", "schooling"], ["ho", "ol"],
                'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["race", "fast", "lane"], ["a"], 'single letter'],
            [["melone", "alone"], ["lone"], 'two words'],
            [["relocate", "delocate", "allocate", "location"],
                ["locat"], 'four words'],
            [["reLocate", "delocate", "allocate"], ["Locate"],
                'case insensitive'],
            [["cdehinotuvw", "inotudehin", "ehinot"], ["ehin", "inot"],
                'interleaved'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
