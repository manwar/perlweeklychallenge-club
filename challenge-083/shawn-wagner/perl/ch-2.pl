#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use experimental qw/postderef/;
use List::Util qw/sum reduce/;

sub combinations {
  if (@_ == 0) {
    return ();
  } elsif (@_ == 1) {
    return ([ $_[0] ], [ -$_[0] ]);
  } else {
    my $elem = shift;
    return map { [ $elem, @$_ ], [ -$elem, @$_ ] } combinations(@_);
    }
}

sub task2 {
  # Going for a functional programming style
  my @sums = grep { $_->[0] > 0 } map { [ sum(@$_), $_ ] } combinations(@_);
  my $minsum = reduce { $a->[0] < $b->[0] ? $a : $b } @sums;
  say length(grep { $_ < 0 } $minsum->[1]->@*);
}

task2 3, 10, 8;
task2 12, 2, 10;
