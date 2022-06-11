#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(Rect->new([-1,0],[2,2])->fullarea(Rect->new([0,-1],[4,4])),22,'example 1');

is(Rect->new([-3,-1],[1,3])->fullarea(Rect->new([-1,-3],[2,2])),25,'example 2');

package Rect;

use List::Util qw(min max);

sub new {
  my ($class,$xy1,$xy2)=@_;
  my $self={
    xy1 => [
      min($xy1->[0],$xy2->[0]),
      min($xy1->[1],$xy2->[1]),
        ],
    xy2 => [
      max($xy1->[0],$xy2->[0]),
      max($xy1->[1],$xy2->[1]),
        ],
  };
  bless $self,$class;
  return $self;
}

sub area {
  my $self=shift;
  my $area=1;
  foreach my $axis (0,1) {
    $area *= $self->{xy2}[$axis] - $self->{xy1}[$axis];
  }
  return $area;
}


sub overlap {
  my $self=shift;
  my $other=shift;
  my $area=1;
  foreach my $axis (0,1) {
    $area *= max(0,
                 min($self->{xy2}[$axis],$other->{xy2}[$axis])-
                 max($self->{xy1}[$axis],$other->{xy1}[$axis])
                   );
  }
  return $area;
}

sub fullarea {
  my $self=shift;
  my $other=shift;
  return $self->area()+$other->area()-$self->overlap($other);
}
