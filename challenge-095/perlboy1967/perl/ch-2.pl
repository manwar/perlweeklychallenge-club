#!/usr/bin/perl

# Perl Weekly Challenge - 095
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/
#
# Task 1 - Palindrome Number
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Data::Printer;

# Unbuffered STDOUT
$|++;


my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;       # removes 0
printf "top: %d\n", $stack->top; # prints -1
p $stack;

$stack->push(0);
printf "min: %d\n", $stack->min; # prints -1
printf "max: %d\n", $stack->max; # prints 2
p $stack;


package Stack;

use List::Util;

sub new {
 my ($class) = @_;

  bless [], $class;
}

sub push {
  my ($this, $value) = @_;

  CORE::push(@$this, $value);
}

sub pop {
  my ($this) = @_;

  CORE::pop(@$this);
}

sub top {
  my ($this) = @_;

  return $this->[-1];
}

sub min {
  my ($this) = @_;

  return List::Util::min(@$this);
}

sub max {
  my ($this) = @_;

  return List::Util::max(@$this);
}
