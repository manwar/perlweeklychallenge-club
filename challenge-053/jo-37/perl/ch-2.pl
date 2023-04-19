#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental qw(signatures);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N
    print vowel strings of length N

EOS


### Input and Output

# Create N counters, chain them, initialize the first counter with all
# vowels and step the last counter while there are values.
main: {
    my @val;
    my @counter;
    my $n = shift;
    for (1 .. $n) {
        push @val, undef;
        push @counter, Counter->new(\$val[-1]);
        if (@counter > 1) {
            $counter[-1]->parent($counter[-2]);
            $counter[-2]->child($counter[-1]);
        }
    }
    $counter[0]->set([qw(a e i o u)]);
    while ($counter[0]) {    
        say @val;
        $counter[-1]->next;
    }
}


### Implementation

# Using "Counter" objects to solve this task.
#
# A counter has:
# - a reference to an (external) scalar that is updated on every state
#   change.
# - an array of possible values
# - a "next" method that steps to the next value
# - a "set" method that initializes the array of possible values.
# Counters are chained as parent / child.  On every state change, a
# child counter is initialized with the new possible values.  If the
# values are exhausted, the parent's "next" method is called.

package Counter;

our %successors;

BEGIN {
    %successors = (
        a => [qw(e i)],
        e => ['i'],
        i => [qw(a e o u)],
        o => [qw(a u)],
        u => [qw(o e)]
    );
}
use overload
    bool => sub ($self, @) {!!$self->{vals}->@*};

sub new ($class, $ref) {
    bless {ref => $ref}, $class;
}

sub parent ($self, $parent) {
    $self->{parent} =  $parent;
}

sub child ($self, $child) {
    $self->{child} = $child;
}

sub set ($self, $vals) {
    $self->{vals} = $vals;
    $self->{cur} = 0;
    _upd($self);
}

sub _upd ($self) {
    my $val = $self->{vals}[$self->{cur}];
    $self->{ref}->$* = defined $val ? $val : '';
    $self->{child}->set($successors{$val})
        if defined $val && defined $self->{child};
}

sub next ($self) {
    if ($self->{cur}++ < $self->{vals}->$#*) {
        _upd($self);
    } else {
        $self->{vals} = [];
        $self->{cur} = -1;
        _upd($self);
        $self->{parent}->next if defined $self->{parent};
    }
}


### Examples and tests

package main;

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        my @vstrings;
        my @tmp;
        my $counter0 = Counter->new(\$tmp[0]);
        my $counter1 = Counter->new(\$tmp[1]);
        $counter0->child($counter1);
        $counter1->parent($counter0);
        $counter0->set([qw(a e i o u)]);
        while ($counter0) {
            push @vstrings, join '', @tmp;
            $counter1->next;
        }
        is [@vstrings], bag {item 'ae'; item 'ai'; item 'ei';
            item 'ia'; item 'io'; item 'iu'; item 'ie'; item 'oa';
            item 'ou';  item 'uo'; item 'ue'; end;},
            'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
