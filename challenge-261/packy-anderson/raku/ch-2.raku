#!/usr/bin/env raku
use v6;

sub multiplyByTwo(@ints, $s) {
  my $start = $s; # so we can modify the value
  my $ints = Set(@ints);
  my @explain;
  my $step = 0;

  while ($start ∈ $ints) {
    $step++;
    my $old = $start;
    $start *= 2;
    @explain.push(
      "Step $step: $old is in the array so $old x 2 = $start"
    );
  }
  @explain.push(
    "$start is not in the array so return $start."
  );
  return ($start, @explain.join("\n"));
}

sub solution(@ints, $start) {
  print 'Input: @ints = (' ~ @ints.join(', ');
  say ") and \$start = $start";
  my ($output, $explain) = multiplyByTwo(@ints, $start);
  say "Output: $output\n\n$explain";
}

say "Example 1:";
solution([5,3,6,1,12], 3);

say "\nExample 2:";
solution([1,2,4,3], 1);

say "\nExample 3:";
solution([5,6,7], 2);