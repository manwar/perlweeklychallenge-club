#!/usr/bin/env raku
use v6;

sub targetArray(@source, @indices) {
  my @target;
  my @explain;

  for 0..@indices.end -> $i {
    @target.splice(@indices[$i], 0, @source[$i]);
    @explain.push: [
      @source[$i], @indices[$i], @target.clone
    ];
  }
  return @target, @explain;
}

sub solution(@source, @indices) {
  say 'Input: @source  = (' ~ @source.join(', ') ~ ')';
  say '       @indices = (' ~ @indices.join(', ') ~ ')';
  my (@output, @explain) := targetArray(@source, @indices);
  say 'Output: (' ~ @output.join(', ') ~ ")\n";

  say '@source @indices @target';
  for @explain -> @row {
    say "@row[0]       @row[1]        (" ~ 
        @row[2].join(', ') ~ ')';
  }
}

say "Example 1:";
solution([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]);

say "\nExample 2:";
solution([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]);

say "\nExample 3:";
solution([1], [0]);