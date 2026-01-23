#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Math::Prime::Util 'forsetproduct';
use List::MoreUtils 'lower_bound';


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
    $0 - generate fractions

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        a positive number

    EOS
}


### Input and Output

say "@{[gen_frac(shift)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/01/23/ch-357.html#task-2

package Rat;

use Math::Prime::Util 'gcd';

sub frac ($class, $n, $d) {
    my $gcd = gcd $n, $d;
    bless [map $_ / $gcd, $n, $d], $class;
}

sub fcmp ($self, $other, $swap) {
    (-1)**!!$swap * ($self->[0] * $other->[1] <=> $other->[0] * $self->[1]);
}

sub fstr ($self, $, $) {
    join '/', @$self;
}

use overload
   '<=>' => \&fcmp,
   '""' => \&fstr; 

package main; 

sub gen_frac ($n) {
    my @frac;
    forsetproduct {
        my $f = Rat->frac(@_);
        my $ix = @frac ? lower_bound {$_ <=> $f} @frac : 0;
        splice @frac, $ix, 0, $f if $ix == @frac || $frac[$ix] != $f;
    } ([1 .. $n]) x 2;

    @frac;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [gen_frac(@$args)];
        is $result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[3], [qw(1/3 1/2 2/3 1/1 3/2 2/1 3/1)], 'example 1'],
            [[4], [qw(1/4 1/3 1/2 2/3 3/4 1/1 4/3 3/2 2/1 3/1 4/1)],
                'example 2'],
            [[1], [qw(1/1)], 'example 3'],
            [[6], [qw(1/6 1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 5/6
                    1/1 6/5 5/4 4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1 6/1)],
                'example 4'],
            [[5], [qw(1/5 1/4 1/3 2/5 1/2 3/5 2/3 3/4 4/5 1/1 5/4
                    4/3 3/2 5/3 2/1 5/2 3/1 4/1 5/1)],
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
