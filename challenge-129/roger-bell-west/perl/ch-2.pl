#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 4;

{
  my $ta=Local::LinkedList->new;
  $ta->append([1,2,3]);
  is_deeply($ta->as_arrayref,[1,2,3],'basics 1');
  $ta->append(4);
  is_deeply($ta->as_arrayref,[1,2,3,4],'basics 2');
}

{
  my $ta=Local::LinkedList->new;
  $ta->append([1,2,3]);
  my $tb=Local::LinkedList->new;
  $tb->append([3,2,1]);
  my $tc=$ta->piecewise_add($tb);
  is_deeply($tc->as_arrayref,[4,4,4],'example 1');
}

{
  my $ta=Local::LinkedList->new;
  $ta->append([1,2,3,4,5]);
  my $tb=Local::LinkedList->new;
  $tb->append([6,5,5]);
  my $tc=$ta->piecewise_add($tb);
  is_deeply($tc->as_arrayref,[1,3,0,0,0],'example 2');
}

package Local::LinkedList;

sub new {
  my $class=shift;
  my $self=[];
  bless $self,$class;
}

sub lastused {
  my $self=shift;
  if ($#{$self}==-1) {
    return -1;
  }
  my $i=0;
  while ($self->[$i]{next} != -1) {
    $i=$self->[$i]{next};
  }
  return $i;
}

sub append {
  my $self=shift;
  my $elem=shift;
  if (ref $elem eq 'ARRAY') {
    map {$self->append($_)} @{$elem};
  } else {
    my $i=$self->lastused;
    push @{$self},{value => $elem,next => -1};
    if ($i > -1) {
      $self->[$i]{next}=$#{$self};
    }
  }
}

sub as_arrayref {
  my $self=shift;
  my @a;
  my $i=0;
  while (defined $self->[$i]) {
    push @a,$self->[$i]{value};
    $i=$self->[$i]{next};
    if ($i == -1) {
      last;
    }
  }
  return \@a;
}

sub piecewise_add {
  my $self=shift;
  my $other=shift;
  my @a=reverse @{$self->as_arrayref};
  my @b=reverse @{$other->as_arrayref};
  while (scalar @a < scalar @b) {
    push @a,0;
  }
  while (scalar @b < scalar @a) {
    push @b,0;
  }
  my @c;
  my $carry=0;
  foreach my $i (0..$#a) {
    my $d=$a[$i]+$b[$i]+$carry;
    push @c,$d % 10;
    $carry=int($d/10);
  }
  if ($carry) {
    push @c,1;
  }
  my $out=Local::LinkedList->new;
  $out->append([reverse @c]);
  return $out;
}
