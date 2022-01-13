#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(p_gp('3/5'),['3/2','1/2'],'example 1');
is_deeply(p_gp('4/3'),['1/3','1/2'],'example 2');

sub p_gp {
  my $s=shift;
  my $f=Local::Fraction->new($s);
  my @out;
  foreach (1..2) {
    $f=$f->get_parent();
    push @out,$f->stringify();
  }
  return \@out;
}

package Local::Fraction;

sub new {
  my $class=shift;
  my $self={
    n => 1,
    d => 1,
      };
  bless $self,$class;
  if (scalar @_ > 0) {
    $self->set_from_string($_[0]);
  }
  return $self;
}

sub get_parent {
  my $self=shift;
  my $p=Local::Fraction->new();
  $p->{n}=$self->{n};
  $p->{d}=$self->{d};
  if ($p->{n} < $p->{d}) {
    $p->{d} -= $p->{n};
  } else {
    $p->{n} -= $p->{d};
  }
  return $p;
}

sub stringify {
  my $self=shift;
  return join('/',$self->{n},$self->{d});
}

sub set_from_string {
  my $self=shift;
  my $s=shift;
  if ($s =~ /^([0-9]+)\/([0-9]+)$/) {
    $self->{n}=$1;
    $self->{d}=$2;
  }
}
