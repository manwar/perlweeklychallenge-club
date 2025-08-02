#!/usr/bin/env perl
use v5.38;

use List::Util qw( min );

sub fmtInts(@ints) {
  return '@ints = (' . join(', ', @ints) . ')';
}

sub getNextIndex($mapping) {
  my $min = min(keys %$mapping);         # note the current min val
  my $i = min(keys %{$mapping->{$min}}); # get the smallest index
  delete $mapping->{$min}{$i};           # remove index from map
  unless (values %{$mapping->{$min}}) {  # no more of this value
    delete $mapping->{$min};             # remove value from map
  }
  return $i; # return the index
}

sub equalizeArray($ints, $x, $y) {
  # track how many of each op, and terminal value
  my $max = -Inf;
  my %mapping;
  my @steps;
  my ($L1, $L2) = (0, 0);
  # loop over the array to determine max value
  # and where the lower numbers are
  foreach my $i ( 0 .. $#{$ints} ) {
    my $int = $ints->[$i];
    $max = $int if ($int > $max);
    $mapping{$int}{$i} = 1;
  }
  # we don't need to operate on values already at the max
  delete $mapping{$max};

  while (keys %mapping) {
    my $elems = scalar(map { keys %$_ } values %mapping);
    if ($elems > 1 && $x * 2 >= $y) {
      # get the two indices
      my $i = getNextIndex(\%mapping);
      my $j = getNextIndex(\%mapping);

      # increment the values
      $ints->[$i]++;
      $ints->[$j]++;
      push @steps,
        "Level 2: i=$i, j=$j, so \$ints[$i] += 1 and " .
        "\$ints[$j] += 1\n" . fmtInts(@$ints);
      $L2++;
      # if the numbers we incremented are less than the max,
      # put them back in the mapping
      $mapping{$ints->[$i]}{$i} = 1 if ($ints->[$i] < $max);
      $mapping{$ints->[$j]}{$j} = 1 if ($ints->[$j] < $max);
    }
    else {
      # get the index
      my $i = getNextIndex(\%mapping);
      # increment the value
      $ints->[$i]++;
      push @steps, "Level 1: i=$i, so \$ints[$i] += 1\n" .
        fmtInts(@$ints);
      $L1++;
      # if the number we incremented is less than the max,
      # put it back in the mapping
      $mapping{$ints->[$i]}{$i} = 1 if ($ints->[$i] < $max);
    }
  }
  my $cost = ($L1 * $x) + ($L2 * $y);
  my @operations;
  push @operations, "Level 1, $L1 " . ($L1 == 1 ? 'time' : 'times')
    if $L1;
  push @operations, "Level 2, $L2 " . ($L2 == 1 ? 'time' : 'times')
    if $L2;
  push @steps,
    'We performed operation ' . join(" and ", @operations) .
    "\nSo the total cost would be ($L1 × \$x) + ($L2 × \$y) => " .
    "($L1 × $x) + ($L2 × $y) => $cost";
  return $cost, join("\n\n", @steps);
}

sub solution($ints, $x, $y) {
  say 'Input: ' . fmtInts(@$ints) . ", \$x = $x and \$y = $y";
  my ($cost, $steps) = equalizeArray($ints, $x, $y);
  say "Output: $cost\n\n$steps";
}

say "Example 1:";
solution([4,1], 3, 2);

say "\nExample 2:";
solution([2, 3, 3, 3, 5], 2, 1);
