#!/usr/bin/env raku
use v6;

sub relativeSort(@list1, @list2) {
  my %bag1 = @list1.BagHash; # because we want to remove elements
  my %bag2 = @list2.Bag;

  # condition checking
  return '@list2 is not distinct'
    unless %bag2.values.all == 1;

  # build the sorted array
  my @sorted;
  for @list2 -> $l2 {
    return "$l2 ∈ \@list2 but $l2 ∉ \@list1"
      if %bag1{$l2}:!exists;

    # put the appropriate number into the list
    @sorted.push(Slip($l2 xx %bag1{$l2}));

    # remove $l2 from what's remaining in @list1
    %bag1{$l2}:delete;
  }

  # push the remaining numbers from @list1 that
  # weren't in @list2 into the output
  for %bag1.keys.sort -> $l1 {
    @sorted.push(Slip($l1 xx %bag1{$l1}));
  }

  return '(' ~ @sorted.join(', ') ~ ')';
}

sub solution(@list1, @list2) {
  say 'Input: @list1 = (' ~ @list1.join(', ') ~ ')';
  say '       @list2 = (' ~ @list2.join(', ') ~ ')';
  say 'Output: ' ~ relativeSort(@list1, @list2);
}

say "Example 1:";
solution([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5],
         [2, 1, 4, 3, 5, 6]);

say "\nExample 2:";
solution([3, 3, 4, 6, 2, 4, 2, 1, 3],
         [1, 3, 2]);

say "\nExample 3:";
solution([3, 0, 5, 0, 2, 1, 4, 1, 1],
         [1, 0, 3, 2]);

say "\nError Condition 1:";
solution([3, 0, 5, 0, 2, 1, 4, 1, 1],
         [1, 0, 3, 2, 0]);

say "\nError Condition 2:";
solution([3, 0, 5, 0, 2, 1, 4, 1, 1],
         [1, 0, 3, 2, 8]);
