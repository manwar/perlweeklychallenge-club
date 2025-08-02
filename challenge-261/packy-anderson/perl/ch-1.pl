#!/usr/bin/env perl
use v5.38;

use List::Util qw( sum );

sub elementDigitSum(@ints) {
  my $elementSum = sum @ints;

  my $explain = 'Element Sum: '
              . join(' + ',  @ints)
              . ' = ' . $elementSum;

  # use join() to concatenate all the integers together
  # into a single string, then use split() to get the
  # individual digits
  my @digits   = split //, join('', @ints);
  my $digitSum = sum @digits;

  $explain .= "\nDigit Sum: "
           . join(' + ',  @digits)
           . ' = ' . $digitSum;

  my $abs = abs($elementSum - $digitSum);

  $explain .= "\nAbsolute Difference: "
           . "| $elementSum - $digitSum | = $abs";

  return ($abs, $explain);
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my ($sum, $explain) = elementDigitSum(@ints);
  say 'Output: ' . $sum;
  say '';
  say $explain;
}

say "Example 1:";
solution(1,2,3,45);

say "\nExample 2:";
solution(1,12,3);

say "\nExample 3:";
solution(1,2,3,4);

say "\nExample 4:";
solution(236, 416, 336, 350);