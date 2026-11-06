#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use File::Basename ();
use constant EXMP => File::Basename::dirname(__FILE__) . 
    '/../../examples/json/ch-2.json';
use experimental 'signatures';

use Math::Prime::Util qw(fromdigits todigits);

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
    $0 - lychrel number

    usage: $0 [-examples] [-tests] [N]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    N
        a positive integer

    EOS
}


### Input and Output

say lychrel(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/06/ch-137.html#task-2

sub lychrel ($n) {
    while () {
        my $rev = fromdigits [reverse todigits $n, 10], 10;
        return 0 if $n == $rev;
        return 1 if $n > 1e7;
        $n += $rev;
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [lychrel(@$args)];

        is $result, $expected,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
    }
    return unless $examples || $tests;

    plan 2;
    my $exmp = JSON->new->utf8->boolean_values(0, 1)->decode(<<~'EOF');
        {
          "challenge": {
            "week": 137,
            "task": 2,
            "name": "Lychel Number"
          },
          "input_vars": [ "$n" ],
          "examples": [
            {
              "name": "Example 1",
              "in": [56],
              "out": [false]
            },
            {
              "name": "Example 2",
              "in": [57],
              "out": [false]
            },
            {
              "name": "Example 3",
              "in": [59],
              "out": [false]
            },
            {
              "name": "Wiki 1",
              "in": [89],
              "out": [true]
            },
            {
              "name": "Wiki 2",
              "in": [196],
              "out": [true]
            }
          ]
        }        
        EOF

    $examples ? subtest_streamed($exmp->{challenge}{name} => sub {
        plan scalar $exmp->{examples}->@*;
        run_example $_->{in}, $_->{out}, $_->{name}
            for $exmp->{examples}->@*;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
