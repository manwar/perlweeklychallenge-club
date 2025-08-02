#!/usr/bin/env raku
use v6;

sub specialElementIndices($n) {
  return (1 .. $n).grep({ $n % $_ == 0 });
}

sub english_list ( *@list ) {
  # given a list, join it in a way that makes sense
  # to english speakers
  my $last = @list.pop(); # last element in array
  if (@list == 0) {
    # using an array in a scalar context returns
    # the number of elements in the array

    # there was only one element in the list
    return $last;
  }
  my $joined = @list.join(qq{,\n});
  if (@list > 1) {
    # if there's more than element, add an Oxford comma
    $joined ~= q{,};
  }
  return "$joined and\n$last";
}

sub specialNumberSquareSum(@ints) {
  my $n = @ints.elems;

  # find the list of indices for "special" numbers
  my @specialIndices = specialElementIndices($n);
  my $count = @specialIndices.elems;
  my @explain_list = @specialIndices.map({
    "\$ints[$_] since $_ divides $n"
  });
  my $explain = "There are exactly $count special elements "
    ~ "in the given array:\n" ~ english_list(@explain_list);

  # find the special numbers themselves
  my @special = @specialIndices.map({ @ints[$_ - 1] });

  # find the sum of the squares
  my $sum = @special.map({ $_ ** 2 }).sum;

  $explain ~= "\nHence, the sum of the squares of all special "
    ~ "elements of given array:\n"
    ~ @special.map({ "$_ * $_" }).join(' + ')
    ~ " = " ~ $sum;

  return (
    $sum,
    $explain
  );
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($sum, $explain) = specialNumberSquareSum(@ints);
  say 'Output: ' ~ $sum;
  say '';
  say $explain;
}

say "Example 1:";
solution([1, 2, 3, 4]);

say "\nExample 2:";
solution([2, 7, 1, 19, 18, 3]);