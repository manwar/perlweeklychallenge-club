#!/usr/bin/env perl
use v5.40;

use List::MoreUtils qw( all );

sub relativeSort($list1, $list2) {
  # thanks to Niels van Dijke (https://github.com/PerlBoy1967)
  # for putting postfix "for" back in my brain!
  my %bag1; $bag1{$_}++ for @$list1;
  my %bag2; $bag2{$_}++ for @$list2;

  # condition checking
  return '@list2 is not distinct'
    unless all {$_ == 1} values %bag2;

  # build the sorted array
  my @sorted;
  foreach my $l2 (@$list2) {
    return "$l2 ∈ \@list2 but $l2 ∉ \@list1"
      if ! exists $bag1{$l2};

    # put the appropriate number into the list
    push @sorted, $_ for ($l2) x $bag1{$l2};

    # remove $l2 from what's remaining in @list1
    delete $bag1{$l2};
  }

  # push the remaining numbers from @list1 that
  # weren't in @list2 into the output
  foreach my $l1 (sort keys %bag1) {
    push @sorted, $_ for ($l1) x $bag1{$l1};
  }

  return '(' . join(', ', @sorted) . ')';
}

sub solution($list1, $list2) {
  say 'Input: @list1 = (' . join(', ', @$list1) . ')';
  say '       @list2 = (' . join(', ', @$list2) . ')';
  say 'Output: ' . relativeSort($list1, $list2);
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
