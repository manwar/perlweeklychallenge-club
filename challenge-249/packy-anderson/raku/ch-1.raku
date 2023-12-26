#!/usr/bin/env raku
use v6;

sub equalPairs(@ints) {
  my @pairs;
  my %num_count;
  # count how many of each int we have
  for @ints -> $num {
    %num_count{$num}++;
  }
  # first, make sure we have even numbers of each integer
  for %num_count.kv -> $k, $v {
    next if $v % 2 == 0; # it's even, we can make pairs
    return @pairs; # we have an odd number, can't make pairs
  }
  # now make pairs from those integers
  for %num_count.kv -> $k, $v {
    my $count = $v; # the values $k, $v are read-only
    while ($count > 0) {
      @pairs.push( [$k, $k] );
      $count -= 2;
    }
  }
  return @pairs;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @pairs = equalPairs(@ints);
  if (@pairs == 0) {
    say 'Output: ()';
  }
  else {
    @pairs = @pairs.map({ qq{($_[0], $_[1])} });
    say 'Output: ' ~ @pairs.join(', ');
  }
}

say "Example 1:";
solution([3, 2, 3, 2, 2, 2]);

say "\nExample 2:";
solution([1, 2, 3, 4]);

say "\nExample 3:";
solution([1, 2, 3, 4, 4, 3, 2, 1]);
