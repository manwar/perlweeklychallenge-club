#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';
use integer;
 

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
    $0 - string alike

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

say +(qw(true false))[!string_alike(shift)];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/11/21/ch-348.html#task-1

sub string_alike ($str) {
    my $l = () = $str =~ /../g;
    my ($h, $t) = map tr/aeiouAEIOU//, $str =~ /^(.{$l})((?1))$/;

    $h && $h == $t;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = string_alike(@$args);
        is $result, $expected,
            "$name: (@$args) -> " . $expected->name;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["textbook"], F(), 'example 1'],
            [["book"], T(), 'example 2'],
            [["AbCdEfGh"], T(), 'example 3'],
            [["rhythmmyth"], F(), 'example 4'],
            [["UmpireeAudio"], F(), 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [["abcab"], F(), 'odd'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
