#!/usr/bin/env perl
use v5.38;

sub targetArray($source, $indices) {
  my @target;
  my @explain;

  foreach my $i ( 0 .. $#{$indices}) {
    splice(@target, $indices->[$i], 0, $source->[$i]);
    push @explain, [
      $source->[$i], $indices->[$i], [ @target ]
    ];
  }
  return \@target, \@explain;
}

sub solution($source, $indices) {
  say 'Input: @source  = (' . join(', ', @$source) . ')';
  say '       @indices = (' . join(', ', @$indices) . ')';
  my ($output, $explain) = targetArray($source, $indices);
  say 'Output: (' . join(', ', @$output) . ")\n";

  say '@source @indices @target';
  foreach my $row ( @$explain ) {
    say "$row->[0]       $row->[1]        (" . 
        join(', ', @{$row->[2]}) . ')';
  }
}

say "Example 1:";
solution([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]);

say "\nExample 2:";
solution([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]);

say "\nExample 3:";
solution([1], [0]);