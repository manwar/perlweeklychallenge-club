#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

package Stack;
use List::Util;

sub new {
    my $class = shift;
    my $self  = bless {}, $class;
    $self->{stack} = [];
    return $self;
}

sub push {
    my ( $self, $value ) = @_;
    push @{ $self->{stack} }, $value;
}

sub pop {
    my $self = shift;
    pop @{ $self->{stack} };
}

sub top {
    my $self = shift;
    return $self->{stack}[-1];
}

sub min {
    my $self = shift;
    return List::Util::min @{ $self->{stack} };
}

package main;

my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;
say $stack->top;
$stack->push(0);
say $stack->min;
