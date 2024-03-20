#!/usr/bin/env raku
use v6;

sub elementDigitSum(@ints) {
  # [+] sums all the elements of @ints
  my $elementSum = [+] @ints;

  my $explain = 'Element Sum: '
              ~ @ints.join(' + ')
              ~ ' = ' ~ $elementSum;

  # use [~] to concatenate all the integers together
  # into a single string, then use split() to get the
  # individual digits
  my @digits   = ([~] @ints).split('', :skip-empty);
  # [+] sums all the elements of @digits
  my $digitSum = [+] @digits;

  $explain ~= "\n" ~ 'Digit Sum: '
              ~ @digits.join(' + ')
              ~ ' = ' ~ $digitSum;

  my $abs = ($elementSum - $digitSum).abs;

  $explain ~= "\nAbsolute Difference: "
           ~ "| $elementSum - $digitSum | = $abs";

  return ($abs, $explain);
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($sum, $explain) = elementDigitSum(@ints);
  say 'Output: ' ~ $sum;
  say '';
  say $explain;
}

say "Example 1:";
solution([1,2,3,45]);

say "\nExample 2:";
solution([1,12,3]);

say "\nExample 3:";
solution([1,2,3,4]);

say "\nExample 4:";
solution([236, 416, 336, 350]);