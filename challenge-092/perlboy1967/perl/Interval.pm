#!/usr/bin/perl

# Perl Weekly Challenge - 092
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-092/
#
# Task 2 - Insert Interval - 'Interval class'
#
# Author: Niels 'PerlBoy' van Dijke

package Interval;

use v5.16;
use strict;
use warnings;

use Scalar::Util qw(looks_like_number);
use Carp qw(confess);

sub new {
  my ($class,$v1,$v2) = @_;

  confess "'$v1' is not a number"
    unless defined $v1 and looks_like_number($v1);
  confess "'$v2' is not a number"
    unless defined $v2 and looks_like_number($v2);

  my @data = sort { $a <=> $b } ($v1, $v2);

  bless \@data, $class;
}

sub min {
  my ($this,$v) = @_;
  $this->[0] = $v if (defined $v);
  $this->[0];
}

sub max {
  my ($this,$v) = @_;
  $this->[1] = $v if (defined $v);
  $this->[1];
}

sub contains { 
  my ($this, $v) = @_;
  return ($v >= $this->min and $v <= $this->max ? 1 : 0);
} 

sub overlaps {
  my ($this, $that) = @_;
  return ($this->contains($that->min)
          or 
          $this->contains($that->max));
}

sub cmp {
  my ($this, $that) = @_;
  return ($this->min <=> $that->min
          or
          $this->max <=> $that->max);
}

sub string {
  my ($this) = @_;
  return sprintf('(%d,%d)', $this->min, $this->max);
}
  
1;
