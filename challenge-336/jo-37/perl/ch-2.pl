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
    $0 - final score

    usage: $0 [-examples] [-tests] [-- S...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    S...
        list of scores

    EOS
}


### Input and Output

say final_score(@ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/29/ch-336.html#task-1

package Score;

sub new ($class) {
    bless [], $class;
}

sub total ($self) {
    List::Util::sum0 @$self;
}

sub apply ($self, @scores) {
    for (@scores) {
        push(@$self, $_), next if /^[-+]?\d+$/;
        pop(@$self), next if /^C$/;
        push(@$self, 2 * ($self->[-1] // 0)), next if /^D$/;
        push(@$self, ($self->[-2] // 0) + ($self->[-1] // 0)), next if /^\+$/;
        die "score invalid: $_";
    }
    $self;
}


package main;

sub final_score {
    Score->new->apply(@_)->total;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = final_score(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["5","2","C","D","+"], 30, 'example 1'],
            [["5","-2","4","C","D","9","+","+"], 27, 'example 2'],
            [["7","D","D","C","+","3"], 45, 'example 3'],
            [["-5","-10","+","D","C","+"], -55, 'example 4'],
            [["3","6","+","D","C","8","+","D","-2","C","+"], 128, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 9;
        
        like dies {Score->new->apply('X')}, qr/score invalid/,
            'score invalid';
        is(Score->new->total, 0, 'empty stack');
        is(Score->new->apply('+')->total, 0, 'zero summands');
        is(Score->new->apply('1')->apply('+')->total, 2, 'one summand');
        is(Score->new->apply('D')->total, 0, 'double nothing');
        is(Score->new->apply('C')->total, 0, 'cancel on empty stack');
        {
            my $x = Score->new;
            $x->apply(3);
            $x->apply(2);
            $x->apply('+');
            is $x->total, 10, 'single scores';
        }
        is(Score->new->apply(3)->apply(2)->apply('+')->total, 10, 'chained');
        is(Score->new->apply(qw(3 2 +))->total, 10, 'multiple scores');
    }) : pass 'skip tests';

    exit;
}
