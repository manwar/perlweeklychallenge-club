#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

# I use `say` instead of `print` because the newlines
# improve readability in the output

my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->all;    # 2, -1, 0

$stack->pop;    # removes 0
$stack->all;

say $stack->top;    # prints -1
$stack->push(0);

$stack->all;
say $stack->min;    # prints -1

say 'DONE';
exit;

# I think a Moose-style implementation would be good for me
package Stack;

# see min, below.
use List::Util;

# creates a new Stack object. Except for the "min" function,
# there's nothing to keep this from handling anything that a
# scalar can hold: number, string, hashref, arrayref, closure
sub newx ( $class ) {
    my $self = {};
    $self->{values} = [];
    return bless $self, $class;
}

sub new ( $class, @values ) {
    my $self = {};
    $self->{values} = [];
    push $self->{values}->@*, @values;
    return bless $self, $class;
}

# 'push' and 'pop' are methods used by Perl's Array type
# to handle stack values, so here we just use them
sub push ( $self, $value ) {
    push $self->{values}->@*, $value;
    return 1;
}

sub pop ( $self ) {
    return pop $self->{values}->@*;
}

# it's harder to reuse subroutines from libraries than
# it is to reuse those provided by Perl, so we have to
# use List::Util and use min's long name rather than
# use List::Util qw{min}, because Perl would think we're
# rewriting min.
sub min ( $self ) {
    return List::Util::min( $self->{values}->@* );
}

# the thing I had to remember that push and pop occur from
# the back of the stack, not the front, and thus top is the
# _last_ value, not the _first_. I could use {values}[0]
# if instead I used shift and unshift.
sub top ( $self ) {
    return $self->{values}[-1];
    return 1;
}

# bookkeeping function so I know what's going on inside
sub all ( $self ) {
    say join "\n\t", 'Size: ' . scalar $self->{values}->@*,
        $self->{values}->@*, '';
    return 1;
}
