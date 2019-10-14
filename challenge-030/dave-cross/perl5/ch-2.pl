#!/usr/bin/perl

use strict;
use warnings;
use feature qw[say state];

use List::Util 'sum';

# If three numbers add to 12 then the
# highest number you can have is 10.
my $max = 10;

for my $x (1 .. $max) {
  for my $y (1 .. $max) {
    for my $z (1 .. $max) {
      say join ', ', $x, $y, $z if valid($x, $y, $z);
    }
  }
}

sub valid {
  state $seen;

  @_ = sort { $a <=> $b } @_;

  return if $seen->{join ',', @_};
  return unless sum(@_) == 12;
  return unless grep { ! ($_ % 2) } @_;
  $seen->{join ',', sort @_} = 1;
  return 1;
}
