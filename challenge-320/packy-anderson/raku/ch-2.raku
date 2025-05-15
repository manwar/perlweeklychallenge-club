#!/usr/bin/env raku
use v6;

sub subDiff(@ints) {
  my $element_sum = @ints.sum;
  my $digit_sum   = @ints.join.comb.sum;
  my $abs_diff    = ($element_sum - $digit_sum).abs;
  my $int_list    = @ints.join(" + ");
  my $digit_list  = @ints.join.comb.join(" + ");
  return (
    $abs_diff,
    "Element sum: $int_list => $element_sum\n" ~
    "Digit sum:   $digit_list => $digit_sum\n" ~
    "Absolute difference: | $element_sum - $digit_sum | " ~
    "=> $abs_diff"
  );
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($diff, $explain) = subDiff(@ints);
  say "Output: $diff\n\n$explain";
}

say "Example 1:";
solution([1, 23, 4, 5]);

say "\nExample 2:";
solution([1, 2, 3, 4, 5]);

say "\nExample 3:";
solution([1, 2, 34]);
