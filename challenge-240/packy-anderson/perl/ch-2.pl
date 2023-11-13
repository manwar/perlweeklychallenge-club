#!/usr/bin/env perl
use v5.38;

sub buildArray(@old) {
  my @new;
  foreach my $i (0 .. $#old) {
    push @new, $old[$old[$i]];
  }
  return @new;
}

sub solution {
  my @int = @_;
  say 'Input: @int = (' . join(', ', @int) . ')';
  my @output = buildArray(@int);
  say 'Output: (' . join(', ', @output) . ')';
}

say "Example 1:";
solution(0, 2, 1, 5, 3, 4);

say "\nExample 2:";
solution(5, 0, 1, 2, 3, 4);