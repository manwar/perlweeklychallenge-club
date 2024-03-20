#!/usr/bin/env perl
use v5.38;

sub multiplyByTwo($start, @ints) {
  my %ints = map { $_ => 1 } @ints;
  my @explain;
  my $step = 0;

  while ( exists $ints{$start} ) {
    $step++;
    my $old = $start;
    $start *= 2;
    push @explain,
      "Step $step: $old is in the array so $old x 2 = $start";
  }
  push @explain,
    "$start is not in the array so return $start.";
  return ($start, join("\n", @explain));
}

sub solution($start, $ints) {
  print 'Input: @ints = (' . join(', ', @$ints);
  say ") and \$start = $start";
  my ($output, $explain) = multiplyByTwo($start, @$ints);
  say "Output: $output\n\n$explain";
}

say "Example 1:";
solution(3, [5,3,6,1,12]);

say "\nExample 2:";
solution(1, [1,2,4,3]);

say "\nExample 3:";
solution(2, [5,6,7]);