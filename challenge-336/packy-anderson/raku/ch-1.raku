#!/usr/bin/env raku
use v6;

sub dividesUnevenly($smallest, $bag) {
  $bag.values.grep({ $_ mod $smallest != 0 })
}

sub equalGroup(@ints) {
  my $bag = @ints.Bag;
  # if we don't have more than 2 instances of
  # a particular int, we can't make groups
  return (False, q{}) if $bag.values.any < 2;

  # find the smallest number of instances of
  # an int in the list
  my $smallest = $bag.values.min;

  # can we divide the list evenly into multiples
  # of the smallest group?
  while (dividesUnevenly($smallest, $bag) && $smallest > 2) {
    # no, let's divide it by 2 and try again
    $smallest = ($smallest / 2).Int;
  }

  # make the groups and return the result
  my $groups;
  if (dividesUnevenly($smallest, $bag)) {
    # we can't evenly divide by $smallest, just
    # make a single group for each unique int
    for $bag.keys.sort -> $k {
      $groups ~= '(' ~ $bag.kxxv.grep($k).join(',') ~ ') ';
    }
    return (False, $groups);
  }
  else {
    # make groups of $smallest
    for $bag.keys.sort -> $k {
      my $count = $bag{$k};
      while ($count) {
        $groups ~= '(' ~ (($k) xx $smallest).join(',') ~ ') ';
        $count -= $smallest;
      }
    }
    return (True, $groups);
  }
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(',') ~ ')';
  my ($result, $groups) = equalGroup(@ints);
  say "Output: $result";
  say "\nGroups: $groups" if $groups;
}

say "Example 1:";
solution([1,1,2,2,2,2]);

say "\nExample 2:";
solution([1,1,1,2,2,2,3,3]);

say "\nExample 3:";
solution([5,5,5,5,5,5,7,7,7,7,7,7]);

say "\nExample 4:";
solution([1,2,3,4]);

say "\nExample 5:";
solution([8,8,9,9,10,10,11,11]);

say "\nExample 6 (2a):";
solution([1,1,1,1,2,2,2,2,3,3]);

say "\nExample 7 (2b):";
solution([1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3]);

say "\nExample 8 (3a):";
solution([5,5,5,5,5,7,7,7,7,7,7]);
