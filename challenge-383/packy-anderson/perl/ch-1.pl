#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( any );

sub similar($list1, $list2, $list3) {
  # are the lists the same length?
  return 'False' unless @$list1 == @$list2;

  # eliminate identical words
  for my $word (@$list1) {
    next unless any { $word eq $_ } @$list2;
    $list1 = [ grep { $_ ne $word } @$list1 ];
    $list2 = [ grep { $_ ne $word } @$list2 ];
  }

  # eliminate "similar" words using list3
  for my $word (@$list1) {
    for my $sublist (@$list3) {
      next unless any { $word eq $_ } @$sublist;
      next unless my ($word2) = grep {
        my $w = $_; any { $_ eq $w } @$list2
      } @$sublist;
      $list1 = [ grep { $_ ne $word  } @$list1 ];
      $list2 = [ grep { $_ ne $word2 } @$list2 ];
    }
  }

  return @$list1 == @$list2 == 0 ? 'True' : 'False';
}

sub solution($list1, $list2, $list3) {
  say 'Input: $list1 = (' . join(', ', map {qq/"$_"/} @$list1) . ')';
  say '       $list2 = (' . join(', ', map {qq/"$_"/} @$list2) . ')';
  my @L3 = map { '[' . join(', ', map {qq/"$_"/} @$_) . ']'} @$list3;
  say '       $list3 = (' . join(', ', @L3) . ')';
  say 'Output: ' . similar($list1, $list2, $list3);
}

say "Example 1:";
solution(["great", "acting"], ["fine", "drama"],
         [["great", "fine"], ["acting", "drama"]]);

say "\nExample 2:";
solution(["apple", "pie"], ["banana", "pie"],
         [["apple", "peach"], ["peach", "banana"]]);

say "\nExample 3:";
solution(["perl4", "python"], ["raku", "python"],
         [["perl4", "perl5", "raku"], ]);

say "\nExample 4:";
solution(["enjoy", "challenge"], ["love", "weekly", "challenge"],
         [["enjoy", "love"], ]);

say "\nExample 5:";
solution(["fast", "car"], ["quick", "vehicle"],
         [["quick", "fast"], ["vehicle", "car"]]);
