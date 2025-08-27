#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( any min );
use Set::Bag;

# for some reason, Set::Bag doesn't have a method that
# will return a list of ALL the values. if $bag->grab()
# is called with a list of keys, it returns the values
# for those keys, but if it's called with no keys, it
# returns a hash of keys => values. so I rolled my own
# method to return a list of all the values...
sub bag_values($bag) { $bag->grab($bag->elements) }

sub dividesUnevenly($smallest, $bag) {
  any { $_ % $smallest != 0 } values(%$bag)
}

sub equalGroup(@ints) {
  my $bag = Set::Bag->new( map { $_ => 1 } @ints );
  # if we don't have more than 2 instances of
  # a particular int, we can't make groups
  return ("false", q{}) if any { $_ < 2 } values(%$bag);

  # find the smallest number of instances of
  # an int in the list
  my $smallest = min values(%$bag);

  # can we divide the list evenly into multiples
  # of the smallest group?
  while (dividesUnevenly($smallest, $bag) && $smallest > 2) {
    # no, let's divide it by 2 and try again
    $smallest = int($smallest / 2);
  }

  # make the groups and return the result
  my $groups;
  if (dividesUnevenly($smallest, $bag)) {
    # we can't evenly divide by $smallest, just
    # make a single group for each unique int
    foreach my $k ( $bag->elements ) {
      my $count = $bag->grab($k);
      $groups .= '(' . join(',', (($k) x $count)) . ') ';
    }
    return ("false", $groups);
  }
  else {
    # make groups of $smallest
    foreach my $k ( $bag->elements ) {
      my $count = $bag->grab($k);
      while ($count) {
        $groups .= '(' . join(',', (($k) x $smallest)) . ') ';
        $count -= $smallest;
      }
    }
    return ("true", $groups);
  }
}

sub solution($ints) {
  say 'Input: @ints = (' . join(',',@$ints) . ')';
  my ($result, $groups) = equalGroup(@$ints);
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
