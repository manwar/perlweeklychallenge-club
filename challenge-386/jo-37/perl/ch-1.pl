#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::MoreUtils 'part';
use Math::Prime::Util 'fromdigits';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - convert to base

    usage: $0 [-examples] [-tests] [N B]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        a digit string in base B

    B
        a positive integer

    EOS
}


### Input and Output

say from_base(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/08/14/ch-386.html#task-1

{
    my @digits;
    my %digits;

    BEGIN {
        @digits = map @$_, part {/[[:punct:]]/}
            grep /[[:alnum:][:punct:]]/, map chr, 0 .. 127;
        @digits{@digits} = (0 .. $#digits);
    }

    sub from_base ($num, $base) {
        die "base too large" if $base > @digits;

        fromdigits([@digits{split //, $num}], $base)
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = from_base(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [['101010',  2], 42,        'example 1'],
            [['EEADEE', 16], 15642094,  'example 2'],
            [['755',     8], 493,       'example 3'],
            [['1BRJB'  ,36], 2228519,   'example 4'],
            [['7MyqL',  64], 123456789, 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
#        like from_base(652859770833, 94), qr/^_`\{\|\}~$/, 'last 6 digits';
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
