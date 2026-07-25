#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util qw(fromdigits todigitstring);


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
    $0 - nearest RGB

    usage: $0 [-examples] [-tests] [COLOR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    COLOR
        an encoded color in the form '#RRGGBB'

    EOS
}


### Input and Output

say web_hex(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/07/24/ch-383.html#task-2

sub web_hex ($str) {
    my $head = substr $str, 0, 1, '';
    $head . join '', map {
        uc todigitstring(int((fromdigits($_, 16) + 25) / 51) * 51, 16, 2)
    } $str =~ /../g;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = web_hex(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["#F4B2D1"], "#FF99CC", 'example 1'],
            [["#15E6E5"], "#00FFCC", 'example 2'],
            [["#191A65"], "#003366", 'example 3'],
            [["#2D5A1B"], "#336633", 'example 4'],
            [["#00FF66"], "#00FF66", 'example 5'],
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
