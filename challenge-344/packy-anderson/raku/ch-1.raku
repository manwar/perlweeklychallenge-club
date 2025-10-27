#!/usr/bin/env raku
use v6;

sub compute(@ints, $x) {
  (@ints.join('').Int + $x).Str.comb;
}

sub solution(@ints, $x) {
  say qq[Input: \@ints = ({ @ints.join(', ') }), \$x = $x];
  say qq[Output: ({ compute(@ints, $x).join(', ') })];
}

say "Example 1:";
solution([1, 2, 3, 4], 12);

say "\nExample 2:";
solution([2, 7, 4], 181);

say "\nExample 3:";
solution([9, 9, 9], 1);

say "\nExample 4:";
solution([1, 0, 0, 0, 0], 9999);

say "\nExample 5:";
solution([0], 1000);
