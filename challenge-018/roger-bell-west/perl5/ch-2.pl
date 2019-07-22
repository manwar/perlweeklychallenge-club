#! /usr/bin/perl

use strict;
use warnings;

my $q=Local::PriorityQueue->new;
$q->insert_with_priority(4,1);
$q->insert_with_priority(3,2);
$q->insert_with_priority(1,3);
$q->insert_with_priority(2,3);
$q->insert_with_priority(5,0);
while (!$q->is_empty) {
  print $q->pull_highest_priority_element,"\n";
}

package Local::PriorityQueue;
use List::Util qw(max);

sub new {
  my $class = shift;
  my $self={};
  bless $self,$class;
  return $self;
}

sub is_empty {
  my $self=shift;
  if (scalar keys %{$self}) {
    return 0;
  }
  return 1;
}

sub insert_with_priority {
  my $self=shift;
  my $element=shift;
  my $priority=shift;
  push @{$self->{$priority}},$element;
}

sub pull_highest_priority_element {
  my $self=shift;
  if ($self->is_empty) {
    return undef;
  }
  my $prio=max(keys %{$self});
  my $element=shift @{$self->{$prio}};
  if (scalar @{$self->{$prio}}==0) {
    delete $self->{$prio};
  }
  return $element;
}
