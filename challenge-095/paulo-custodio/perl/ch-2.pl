#!/usr/bin/perl

# Challenge 095
#
# TASK #2 › Demo Stack
# Submitted by: Mohammad S Anwar
# Write a script to demonstrate Stack operations like below:
#
# push($n) - add $n to the stack
# pop() - remove the top element
# top() - get the top element
# min() - return the minimum element
#
# Example:
# my $stack = Stack->new;
# $stack->push(2);
# $stack->push(-1);
# $stack->push(0);
# $stack->pop;       # removes 0
# print $stack->top; # prints -1
# $stack->push(0);
# print $stack->min; # prints -1

use strict;
use warnings;
use 5.030;

{
    package Stack;

    sub new     { my($class) = @_;      return bless [], $class; }
    sub push    { my($self, $n) = @_;   push @$self, $n; }
    sub pop     { my($self) = @_;       pop  @$self; }
    sub top     { my($self) = @_;       return $self->[-1]; }
    sub min     { my($self) = @_;       return min_(@$self); }

    sub min_ {
        my($min, @a) = @_;
        for (@a) {
            $min = $_ if $min > $_;
        }
        return $min;
    }
}

my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;        # removes 0
say $stack->top;    # prints -1
$stack->push(0);
say $stack->min;    # prints -1
