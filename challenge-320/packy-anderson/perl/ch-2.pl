#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );

sub subDiff(@ints) {
  my $element_sum = sum @ints;
  my $digit_sum   = sum split(//, join(q{}, @ints));
  my $abs_diff    = abs($element_sum - $digit_sum);
  my $int_list    = join " + ", @ints;
  my $digit_list  = join " + ", split(//, join(q{}, @ints));
  return (
    $abs_diff,
    "Element sum: $int_list => $element_sum\n" .
    "Digit sum:   $digit_list => $digit_sum\n" .
    "Absolute difference: | $element_sum - $digit_sum | " .
    "=> $abs_diff"
  );
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my ($diff, $explain) = subDiff(@$ints);
  say "Output: $diff\n\n$explain";
}

say "Example 1:";
solution([1, 23, 4, 5]);

say "\nExample 2:";
solution([1, 2, 3, 4, 5]);

say "\nExample 3:";
solution([1, 2, 34]);
