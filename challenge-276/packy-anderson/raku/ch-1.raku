#!/usr/bin/env raku
use v6;

sub completeDays(@hours) {
  my @pairs;
  for 0 .. @hours.end - 1 -> $i {
    for $i + 1 .. @hours.end -> $j {
      @pairs.push([ @hours[$i], @hours[$j] ])
        if ( @hours[$i] + @hours[$j] ) % 24 == 0;
    }
  }
  my $explain = "";
  for @pairs.kv -> $i, @p {
    $explain ~= "\n" ~ "Pair " ~ ($i+1) ~ ": ("
             ~ @p.join(", ") ~ ")"
  }
  return @pairs.elems, $explain;
}

sub solution(@hours) {
  say 'Input: @hours = (' ~ @hours.join(', ') ~ ')';
  my ($count, $explain) = completeDays(@hours);
  say "Output: $count\n$explain";
}

say "Example 1:";
solution([12, 12, 30, 24, 24]);

say "\nExample 2:";
solution([72, 48, 24, 5]);

say "\nExample 3:";
solution([12, 18, 24]);
