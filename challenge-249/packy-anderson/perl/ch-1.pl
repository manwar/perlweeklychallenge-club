#!/usr/bin/env perl
use v5.38;

sub equalPairs(@ints) {
  my @pairs;
  my %num_count;
  # count how many of each int we have
  foreach my $num ( @ints ) {
    $num_count{$num}++;
  }
  # first, make sure we have even numbers of each integer
  foreach my $k ( keys %num_count ) {
    my $v = $num_count{$k};
    next if $v % 2 == 0; # it's even, we can make pairs
    return @pairs; # we have an odd number, can't make pairs
  }
  # now make pairs from those integers
  foreach my $k ( keys %num_count ) {
    my $count = $num_count{$k};
    while ($count > 0) {
      push @pairs, [$k, $k];
      $count -= 2;
    }
  }
  return @pairs;
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my @pairs = equalPairs(@ints);
  if (@pairs == 0) {
    say 'Output: ()';
  }
  else {
    @pairs = map { qq{($_->[0], $_->[1])} } @pairs;
    say 'Output: ' . join(', ', @pairs);
  }
}

say "Example 1:";
solution(3, 2, 3, 2, 2, 2);

say "\nExample 2:";
solution(1, 2, 3, 4);

say "\nExample 3:";
solution(1, 2, 3, 4, 4, 3, 2, 1);