package Stack;
use strict;
use warnings;
use List::Util;

sub new{
  my $class = ref($_[0]) || $_[0];
  my $self = bless [], $class;
}

sub push {
  my ($self, $item) = @_;
  CORE::push @$self, $item;
}

sub pop {
  my ($self) = @_;
  CORE::pop @$self;
}

sub top {
  my ($self) = @_;
  $self->[@$self - 1];
}

sub min {
  my ($self) = @_;
  List::Util::min @$self;
}

1;
