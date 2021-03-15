#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

my $stack=Local::Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
is($stack->pop,0,'test 1');       # removes 0
is($stack->top,-1,'test 2'); # prints -1
$stack->push(0);
is($stack->min,-1,'test 3'); # prints -1

package Local::Stack;
use List::Util;

sub new {
  my $class=shift;
  my $self=[];
  bless $self,$class;
}

sub push {
  my $self=shift;
  my $op=shift;
  push @{$self},$op;
}

sub pop {
  my $self=shift;
  if (scalar @{$self} == 0) {
    die "insufficient elements for pop\n";
  }
  return pop @{$self};
}

sub top {
  my $self=shift;
  if (scalar @{$self} == 0) {
    die "insufficient elements for top\n";
  }
  return $self->[-1];
}

sub min {
  my $self=shift;
  if (scalar @{$self} == 0) {
    die "insufficient elements for min\n";
  }
  return List::Util::min(@{$self});
}
