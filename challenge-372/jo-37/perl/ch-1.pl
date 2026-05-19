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
    $0 - rearrange spaces

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

say "'@{[rearrange_spaces(shift)]}'";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/08/ch-372.html#task-1

sub rearrange_spaces ($str) {
    my @words = split ' ', $str;
    my $rep = @words > 1 ? @words - 2 : 0;

    no warnings 'uninitialized';
    $str =~ tr/ //cdr =~ s{^(?(?{@words > 1})( +)\1{$rep})( *)$}
        {join($1, @words) . $2}er;
}

### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = rearrange_spaces(@$args);
        is $result, $expected,
            "$name: '@$args' -> '$expected'";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["  challenge  "], "challenge    ", 'example 1'],
            [["coding  is  fun"], "coding  is  fun", 'example 2'],
            [["a b c  d"], "a b c d ", 'example 3'],
            [["  team      pwc  "], "team          pwc", 'example 4'],
            [["   the  weekly  challenge  "],"the    weekly    challenge ",
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
