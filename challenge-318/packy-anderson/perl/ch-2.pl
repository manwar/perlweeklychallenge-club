#!/usr/bin/env perl
use v5.40;

sub arrayEquals($a, $b) {
  return join(',', @$a) eq join(',', @$b);
}

sub reverseEquals($source, $target) {
  # deal with the trivial cases
  if (@$source != @$target) {
    # @source and @target are different lengths
    return ("False", "");
  }
  if (arrayEquals($source, $target)) {
    # they're already the same
    return ("True", "");
  }
  # ok, now we start checking subarrays
  foreach my $i ( 0 .. $#{$source} - 1 ) {
    foreach my $j ( $i+1 .. $#{$source} ) {
      my @reversed;
      @reversed = @$source[0..$i-1] if $i > 0;
      push @reversed, reverse @$source[$i..$j];
      push @reversed, @$source[$j+1..$#{$source}]
        if $j < $#{$source};
      return ("True", "$i-$j") if arrayEquals(\@reversed, $target);
    }
  }
  return ("False", "");
}

sub solution($source, $target) {
  say 'Input: @source = (' . join(', ', @$source) . ')';
  say '       @target = (' . join(', ', @$target) . ')';
  my ($equals, $elements) = reverseEquals($source, $target);
  say 'Output: ' . $equals;
  say "\nReverse elements: " . $elements if $elements;
}

say "Example 1:";
solution([3, 2, 1, 4], [1, 2, 3, 4]);

say "\nExample 2:";
solution([1, 3, 4], [4, 1, 3]);

say "\nExample 3:";
solution([2], [2]);
