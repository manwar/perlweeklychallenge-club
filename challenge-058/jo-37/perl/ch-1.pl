#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use Debug::Filter::PrintExpr;
use experimental 'signatures';


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
    $0 - compare version

    usage: $0 [-examples] [-tests] [V1 V2]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    V1 V2
        two version numbers

    EOS
}


### Input and Output

say compare_version(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/10/30/ch-058.html#task-1

sub compare_version ($v1, $v2) {
    state sub vstr ($v) {
        $v =~ m{^(?:\d++\.?+)++(?:_\d++)*+$} or die "version invalid: $v";
        pack "i>*",
            map /\./ ? -1 :
                /_/  ? -2 : $_,
            split /(\.|_)/, shift;
    }

    no locale;
    vstr($v1) cmp vstr($v2);
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [compare_version(@$args)];

        is $result, $expected,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
    }
    return unless $examples || $tests;

    plan 2;
    my $exmp = {challenge => {week => 58, task => 1, name => 'Compare Version'},
        examples => [
            {name => 'example 1', in => ['0.1', '1.1'], out => [-1]},
            {name => 'example 2', in => ['2.0', '1.2'], out => [1]},
            {name => 'example 3', in => ['1.2', '1.2_5'], out => [-1]},
            {name => 'example 4', in => ['1.2.1', '1.2_1'], out => [1]},
            {name => 'example 5', in => ['1.2.1', '1.2.1'], out => [0]},
        ],
        input_vars => ['$v1', '$v2'],
    };
    ##\{$exmp}

    $examples ? subtest_streamed($exmp->{challenge}{name} => sub {
        plan scalar $exmp->{examples}->@*;
        run_example $_->{in}, $_->{out}, $_->{name}
            for $exmp->{examples}->@*;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        like dies {compare_version('1.0', '1.x')}, qr/version invalid/,
            'version invalid';
    }) : pass 'skip tests';

    exit;
}
