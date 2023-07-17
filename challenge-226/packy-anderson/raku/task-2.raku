#!/usr/bin/env raku

sub min_positive (@ints) {
  my @positive = @ints.grep({ $_ > 0 }); # only consider positive numbers
  return unless @positive.elems;         # return early if no positive nums
  return @positive.reduce(&min);         # find smallest
}

sub zero_array (@ints) {
  say "Input: \@ints = (" ~ @ints.join(', ') ~ ")";
  my @operations;
  while ( my $min = min_positive(@ints) ) {
    my $op_num = @operations.elems + 1;
    for @ints <-> $int {
      $int -= $min if $int > 0;
    }
    @operations.push("operation $op_num: pick $min => (" ~ @ints.join(', ') ~ ")");
  }
  say "Output: " ~ @operations.elems;
  if (@operations) {
    say "";
    say @operations.join("\n");
  }
}

say "Task 2: Zero Array";
say "\nExample 1";
zero_array([1, 5, 0, 3, 5]);

say "\nExample 2";
zero_array([0]);

say "\nExample 3";
zero_array([2, 1, 4, 0, 3]);
