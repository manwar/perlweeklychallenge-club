#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings FATAL => 'all';
use experimental 'signatures';

our ($tests, $examples, $verbose);

$Stack::verbose = 1 if $verbose;

run_tests() if $tests;    # does not return

# prepare example run
unshift @ARGV, 'ch-2-ex.pl' if $examples;

say(<<EOS), exit unless @ARGV;
usage: $0 [-tests] [-examples] [-verbose] [--] [file]

-tests
    run some tests

-examples
    run example

-verbose
    show stack operations

file
    run commands from file
    (use 'ch-2-ex.pl' to run the example)

EOS


### Process input script

do "$ARGV[0]";
die $@ if $@;
die "$ARGV[0]: ", $! if $!;


### Implementation

# Taking this task as an opportunity to practice AUTOLOADing methods and
# overriding "can".  Though this is highly flexible and extensible it
# comes with some overhead.
# Using a blessed array ref as Stack object.

package Stack;

use Carp 'croak';
use List::Util;

our ($verbose, @stack, $arg);

BEGIN {
    # The %method hash maps the name of a method to a subref providing
    # its "base" functionality.  The subs will be called with the
    # variables @stack and $arg set to the current stack and the
    # optional method argument respective.
    my %method = (
        push => sub {push @stack, $arg}, # returns new stack size
        pop => sub {pop @stack},         # returns removed element
        top => sub {$stack[$#stack]},
        min => sub {List::Util::min @stack},
        max => sub {List::Util::max @stack},
        size => sub {@stack},            # returns current stack size
        clear => sub {splice @stack},    # returns top element
    );

    # Wrapping the "base" functionality in an object.  For this purpose
    # override "can" to return an existing or generated $method.  Must
    # be available at compile time.
    sub can ($self, $method) {
        # Retrieve parent methods as well as the defined methods
        # of this class.
        my $can = $self->SUPER::can($method);
        return $can if $can;

        my $call = $method{$method};
        return unless $call;

        # Generate a method to perform the configured call.
        sub ($self, $val=undef) {
            # Provide variables and call method sub.
            local $arg = $val;
            local *stack = $self; # make @$self available as @stack
            my $result = &$call();

            # Benefit from method generation: single code for every
            # method.
            no warnings 'uninitialized';
            say "$method($val): $result" if $verbose;

            $result;
        }
    }
}

# Autoload dynamic methods
our $AUTOLOAD;
sub AUTOLOAD ($self, @args) {
    my $called = $AUTOLOAD =~ s/.*:://r;
    my $method = $self->can($called);
    croak qq{Can't locate object method "$called" via package "}
        . __PACKAGE__ . '"' unless $method;

    $self->$method(@args);
}

# Creates an empty Stack.
sub new ($class) {
    bless [], $class;
}


### Tests

package main;

sub run_tests {
    my $stack = Stack->new;

    is $stack->size, 0, 'empty';
    is $stack->min, U(), 'no min from empty stack';
    is $stack->max, U(), 'no max from empty stack';
    is $stack->top, U(), 'no top from empty stack';
    is $stack->pop, U(), 'no pop from empty stack';
    is $stack->push(2), 1, '1 element on stack';
    is $stack->size, 1, 'after first push';
    is $stack->push(-1), 2, '2 elements on stack';
    is $stack->size, 2, 'after second push';
    is $stack->push(0), 3, '3 elements on stack';
    is $stack->size, 3, 'after third push';
    is $stack->pop, 0, 'pop';
    is $stack->size, 2, 'after pop';
    is $stack->top, -1, 'top';
    is $stack->push(0), 3, '3 elements on stack';
    is $stack->size, 3,  'after fourth push';
    is $stack->min, -1, 'minimum';
    is $stack->max, 2, 'maximum';
    is $stack->clear, 0, 'clear stack';
    is $stack->size, 0, 'empty stack';

    SKIP: {
        $stack->push(-1);
        ok my $can = $stack->can('can'), 'inquires parent for "can"'
            or skip 'cannot can';
        ok my $pop = $stack->$can('pop'), 'retrieve "pop" ref'
            or skip 'cannot pop';
        is $stack->$pop, -1, 'invoke "pop" ref';
    }
    like dies {$stack->foo}, qr/Can't locate object method/, 'method missing';

    done_testing;
    exit;
}
