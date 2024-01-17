#!/usr/bin/env perl
use v5.38;

use List::Util qw( sum );

sub specialElementIndices($n) {
  return grep { $n % $_ == 0 } 1 .. $n;
}

sub english_list ( @list ) {
  # given a list, join it in a way that makes sense
  # to english speakers
  my $last = pop @list; # last element in array
  if (@list == 0) {
    # using an array in a scalar context returns
    # the number of elements in the array

    # there was only one element in the list
    return $last;
  }
  my $joined = join qq{,\n}, @list;
  if (@list > 1) {
    # if there's more than element, add an Oxford comma
    $joined .= q{,};
  }
  return "$joined and\n$last";
}

sub specialNumberSquareSum(@ints) {
  # in scalar context, an array evaluates to the number
  # of elements in the array
  my $n = @ints;

  # find the list of indices for "special" numbers
  my @specialIndices = specialElementIndices($n);
  my $count = @specialIndices;
  my @explain_list = map {
    "\$ints[$_] since $_ divides $n"
  } @specialIndices;
  my $explain = "There are exactly $count special elements "
    . "in the given array:\n" . english_list(@explain_list);

  # find the special numbers themselves
  my @special = map { $ints[$_ - 1] } @specialIndices;

  # find the sum of the squares
  my $sum = sum( map { $_ ** 2 } @special);

  $explain .= "\nHence, the sum of the squares of all special "
    . "elements of given array:\n"
    . join(' + ', map { "$_ * $_" } @special)
    . " = " . $sum;

  return (
    $sum,
    $explain
  );
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my ($sum, $explain) = specialNumberSquareSum(@ints);
  say 'Output: ' . $sum;
  say '';
  say $explain;
}

say "Example 1:";
solution(1, 2, 3, 4);

say "\nExample 2:";
solution(2, 7, 1, 19, 18, 3);