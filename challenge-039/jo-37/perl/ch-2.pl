#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Regexp::Common 'number';
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [FILE]

-examples
    run the examples from the challenge
 
-tests
    run some tests

FILE
    read commands from FILE. Use '-' for STDIN.

EOS


### Input and Output

# Valid input tokens:
# - numbers             are pushed to the stack
# - '+', '-', '*', '/'  perform the respective operation
# - 'C'                 clear the stack
# - 'Q'                 quit
# After each input line the top element from the stack is printed.

main: {
    my $rpn = RPN->new;
    line:
    while (<>) {
        for my $in (split /\s+/) {
            ($in =~ /^$RE{num}{real}$/ && $rpn->enter($in) ||
            $in =~ /^\+$/ && $rpn->plus ||
            $in =~ /^\-$/ && $rpn->minus ||
            $in =~ /^\*$/ && $rpn->mul ||
            $in =~ /^\/$/ && $rpn->div ||
            $in =~ /^C$/ && $rpn->clr) && next;
            $in =~ /^Q$/ && exit;
            say "input invalid";
            next line;
        }
        say '=> ', $rpn->get;
    }
}


### Implementation

# A simplistic RPN calculator providing the operations:
# - enter: push a value onto the stack
# - plus: add the two entries at the top
# - minus: subtract the two entries at the top
# - mul: multiply the two entries at the top
# - div: divide the two entries at the top
# - clear: remove all entries from the stack
# - get: get the top entry
# All operations except "get" return the RPN object and thus may be
# chained, see tests below.

package RPN;
use Data::Dump;

sub new ($class) {
    bless [], $class;
}

sub enter ($self, $value) {
    unshift @$self, $value;
    $self;
}

sub plus ($self) {
    splice @$self, 0, 2, $self->[1] + $self->[0];
    $self;
}

sub minus ($self) {
    splice @$self, 0, 2, $self->[1] - $self->[0];
    $self;
}

sub mul ($self) {
    splice @$self, 0, 2, $self->[1] * $self->[0];
    $self;
}

sub div ($self) {
    splice @$self, 0, 2, $self->[1] / $self->[0];
    $self;
}

sub clr ($self) {
    @$self = ();
    $self;
}

sub get ($self) {
    @$self ? $self->[0] : ();
}


### Examples and tests

package main;

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
    }

    SKIP: {
        skip "tests" unless $tests;

        is(RPN->new->enter(3)->enter(5)->mul->enter(8)->minus->enter(11)
        ->plus->enter(2)->div->get, 9, '3 5 * 8 - 11 + 2 /');
	}

    done_testing;
    exit;
}
