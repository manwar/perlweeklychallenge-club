#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);

# Stack package
{
  package Stack;

  use List::Util;

  sub new {
    my $class = shift;
    my @arr = ();

    return bless \@arr, $class;
  }

  sub push {
    my ($self, $elem) = @_;
    push @{$self}, $elem;
  }

  sub pop {
    my ($self) = @_;
    return pop @{$self};
  }

  sub top {
    my ($self) = @_;
    return @{$self}[-1];
  }

  sub min {
    my ($self) = @_;
    return List::Util::min(@{$self});
  }

  sub toString {
    my ($self) = @_;
    say ("[", (join ",", @{$self}), "]");
  }
}

# Input
my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;     # removes 0
say $stack->top; # prints -1
$stack->push(0);
say $stack->min; # prints -1
$stack->toString;