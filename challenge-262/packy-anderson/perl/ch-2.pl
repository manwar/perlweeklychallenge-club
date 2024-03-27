#!/usr/bin/env perl
use v5.38;

sub countEquDiv($k, @ints) {
  my @explain;
  my $cnt = 0;
  foreach my $i ( 0 .. $#ints - 1 ) {
    foreach my $j ( $i + 1 .. $#ints ) {
      # does ints[i] == ints[j]?
      next unless $ints[$i] == $ints[$j];
      # is i x j divisible by k?
      next unless ( ($i * $j) % $k ) == 0;
      # count the pair and explain why
      $cnt++;
      push @explain,
        "($i, $j) => ints[$i] == ints[$j] " .
        "and $i x $j is divisible by $k";
    }
  }
  return($cnt, join("\n", @explain));
}

sub solution($k, @ints) {
  say 'Input: @arr = (' . join(', ', @ints)
    . ') and $k = ' . $k;
  my ($cnt, $explain) = countEquDiv($k, @ints);
  say "Output: $cnt\n\n$explain";
}

say "Example 1:";
solution(2, 3,1,2,2,2,1,3);

say "\nExample 2:";
solution(1, 1,2,3);