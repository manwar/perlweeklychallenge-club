#! /usr/bin/perl

use strict;
use warnings;

my $q=Local::LRU->new($ARGV[0] || 3);
$q->set(1,3);
$q->set(2,5);
$q->set(3,7);
print $q->get(2)," = 5\n";
print $q->get(1)," = 3\n";
print $q->get(4)," = -1\n";
$q->set(4,9);
print $q->get(3)," = -1\n";

package Local::LRU;

sub new {
  my $class = shift;
  my $self={};
  $self->{size}=shift || 3;
  $self->{store}={};
  $self->{lru}=[];
  bless $self,$class;
  return $self;
}

sub set {
  my $self=shift;
  my $k=shift;
  my $v=shift;
  $self->{store}{$k}=$v;
  $self->update_lru($k);
  if (scalar @{$self->{lru}} > $self->{size}) {
    delete $self->{store}{$self->{lru}[0]};
    shift @{$self->{lru}};
  }
}

sub get {
  my $self=shift;
  my $k=shift;
  if (exists $self->{store}{$k}) {
    $self->update_lru($k);
    return $self->{store}{$k};
  } else {
    return -1;
  }
}

sub update_lru {
  my $self=shift;
  my $k=shift;
  my @l=grep {$_ != $k} @{$self->{lru}};
  push @l,$k;
  @{$self->{lru}}=@l;
}
