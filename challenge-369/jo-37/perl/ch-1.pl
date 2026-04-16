#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


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
    $0 - valid tag

    usage: $0 [-examples] [-tests] [--] [STR...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR...
        a string or list of words

    EOS
}


### Input and Output

say valid_tag("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/04/17/ch-369.html#task-1

sub valid_tag {
    substr '#' . lcfirst(
        lc(shift) =~
        s/(?<![a-z])(?=[a-z])([-a-z]+)(?<=[a-z])(?![a-z])/\u$1/gr =~
        tr/a-zA-Z//cdr
    ),
    0, 100;
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = valid_tag(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["Cooking with 5 ingredients!"], "#cookingWithIngredients",
                'example 1'],
            [["the-last-of-the-mohicans"], "#thelastofthemohicans",
                'example 2'],
            [["  extra spaces here"], "#extraSpacesHere",
                'example 3'],
            [["iPhone 15 Pro Max Review"], "#iphoneProMaxReview",
                'example 4'],
            [["Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"],
                "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn",
                'example 5'],
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
